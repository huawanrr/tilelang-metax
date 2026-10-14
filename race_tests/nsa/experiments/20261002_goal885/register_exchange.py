def bit_expr(var, axes):
    return ' + '.join((f'(({var} // {1 << bit}) % 2) * {1 << axis}' for bit, axis in enumerate(axes))) or '0'

def exchange(prefix, d, bs, vec, value):
    db, rb = (d.bit_length() - 1, bs.bit_length() - 1)
    total_bits, local_bits = (db + rb, db + rb - 6)
    word_bits = local_bits - 1
    count = 1 << word_bits
    if value in {'K', 'Q'}:
        local_axes = [0, 1, 2] + list(range(9, total_bits))
        lane_axes = list(range(3, 9))
        target_local = [0, 1, 2] + list(range(db + 4, total_bits)) + list(range(5, db))
        target_lanes = list(range(db, db + 4)) + [3, 4]
    else:
        vector_bits = vec.bit_length() - 1
        lane_axes = list(range(vector_bits, vector_bits + 4)) + [db + 2, db + 3]
        local_axes = [x for x in range(total_bits) if x not in lane_axes]
        target_local = [db, db + 1] + list(range(4, db)) + list(range(db + 4, total_bits))
        target_lanes = list(range(4)) + [db + 2, db + 3]
    assert len(local_axes) == len(target_local) == local_bits
    assert sorted(local_axes + lane_axes) == sorted(target_local + target_lanes) == list(range(total_bits))
    axes = local_axes + lane_axes
    allocations = [f'{prefix}_raw = T.alloc_local([{count * 2}], T.float16)', f'{prefix}_w0 = T.Tensor([{count}], T.uint32, data={prefix}_raw.data, scope="local")']
    loads = [f'for slot in T.unroll({count * 2 // vec}):', f'    for e in T.vectorized({vec}):', f"        linear = {bit_expr(f'(slot * {vec} + e)', local_axes)} + {bit_expr('tid', lane_axes)}", f'        {prefix}_raw[slot * {vec} + e] = T.if_then_else(i_s + linear // {d} < seq_len,', f'            {value}[i_b, i_s + linear // {d}, i_h, linear % {d}], T.float16(0))']
    if value == 'Q':
        loads = loads[:3] + [f'        {prefix}_raw[slot * {vec} + e] = Q[i_b, i_t, i_h * G + linear // {d}, linear % {d}]']
    statements = []
    current, stage = (f'{prefix}_w0', 0)

    def next_buffer():
        nonlocal stage
        stage += 1
        name = f'{prefix}_w{stage}'
        allocations.append(f'{name} = T.alloc_local([{count}], T.uint32)')
        return name
    if axes[0] != target_local[0]:
        pos = axes.index(target_local[0])
        assert 1 <= pos < local_bits
        delta = 1 << pos - 1
        output = next_buffer()
        for a in range(count):
            if a & delta:
                continue
            b = a | delta
            statements.extend([f'{output}[{a}] = ({current}[{a}] & T.uint32(65535)) | ({current}[{b}] << T.uint32(16))', f'{output}[{b}] = ({current}[{a}] >> T.uint32(16)) | ({current}[{b}] & T.uint32(4294901760))'])
        current = output
        axes[0], axes[pos] = (axes[pos], axes[0])
    desired_registers = set(target_local[1:])
    for pos in range(1, local_bits):
        if axes[pos] in desired_registers:
            continue
        missing = next((axis for axis in target_local[1:] if axis not in axes[1:local_bits]))
        lane_pos = axes.index(missing)
        assert lane_pos >= local_bits
        register_delta = 1 << pos - 1
        lane_delta = 1 << lane_pos - local_bits
        output = next_buffer()
        for a in range(count):
            if a & register_delta:
                continue
            b = a | register_delta
            name = f'{prefix}_cross_{stage}_{a}'
            statements.extend([f'{name} = T.shfl_xor(T.if_then_else(tid & {lane_delta} == 0, {current}[{b}], {current}[{a}]), {lane_delta}, 64, 0xffffffffffffffff)', f'{output}[{a}] = T.if_then_else(tid & {lane_delta} == 0, {current}[{a}], {name})', f'{output}[{b}] = T.if_then_else(tid & {lane_delta} == 0, {name}, {current}[{b}])'])
        current = output
        axes[pos], axes[lane_pos] = (axes[lane_pos], axes[pos])
    assert set(axes[1:local_bits]) == desired_registers
    output = next_buffer()
    src_lane = ' + '.join((f'((tid // {1 << target_lanes.index(axis)}) % 2) * {1 << bit}' for bit, axis in enumerate(axes[local_bits:])))
    for dest in range(count):
        src = sum(((dest >> target_local.index(axis) - 1 & 1) << bit for bit, axis in enumerate(axes[1:local_bits])))
        statements.append(f'{output}[{dest}] = T.shfl_sync({current}[{src}], {src_lane}, 64, 0xffffffffffffffff)')
    allocations.append(f'{prefix}_mma = T.Tensor([{count * 2}], T.float16, data={output}.data, scope="local")')
    return (allocations, loads, statements)

def indent(lines, n=16):
    return '\n'.join((' ' * n + line for line in lines))
