"""Read actual LDS launch size and occupancy for a packed two-dimensional grid."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]


def load(path,name):
    spec=importlib.util.spec_from_file_location(name,path)
    mod=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def digest(b):
    return hashlib.sha256(b).hexdigest()


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--binary-report',required=True)
    parser.add_argument('--output-dir',required=True)
    args=parser.parse_args()
    source=Path(args.binary_report)
    report=json.loads(source.read_text())
    out=Path(args.output_dir)
    out.mkdir(exist_ok=False)
    helper=load(ROOT/'experiments/20261016_s8_phases/audit_occupancy.py','occupancy_helper')
    audit=load(ROOT/'experiments/20261015_goal8933/audit_binary.py','binary_helper')
    lib=helper.runtime()
    helper.checked(lib,'mcSetDevice',0)
    result={'binary_report':str(source),'binary_report_sha256':digest(source.read_bytes()),'rows':[]}
    for row in report['rows']:
        c=row['config']
        for index,entry in enumerate(row['modules']):
            mod=audit.helpers.load_module(entry['path'])
            fn=mod._get_kernel(c['B'],c['SEQ_LEN'],c['H'],c['HQ'],c['D'],c['S'],c['block_size'],c['is_causal'],0.1)
            part=audit.helpers.parts(fn)[1]
            assert digest(part.get_kernel_source().encode())==entry['parts'][1]['device_source_sha256']
            host=part.get_host_source()
            calls=list(re.finditer(r'TVMFFIFunctionCall\(kernel_kernel_packed, \(TVMFFIAny\*\) stack_ffi_any, (\d+),',host))
            assert len(calls)==1
            call=calls[0]
            argc=int(call.group(1))
            assert argc==10,argc
            assignments=re.findall(r'\[(\d+)\]\.v_int64\) = \(\(int64_t\)(\d+)\);',host[:call.start()])
            values={int(k):int(v) for k,v in assignments}
            launch=[values[i] for i in range(4,10)]
            assert launch[2:5]==[64,1,1],launch
            stem=f"{row['case']}_m{index}_p1"
            elf=(source.parent/(stem+'.elf')).read_bytes()
            assert digest(elf)==entry['parts'][1]['elf_sha256']
            query=helper.query(lib,elf,launch[-1])
            item=dict(case=row['case'],module=entry['path'],launch=launch,**query)
            (out/(stem+'.host.cpp')).write_text(host)
            result['rows'].append(item)
            (out/'report.json').write_text(json.dumps(result,indent=2)+'\n')
            print(entry['path'],launch,query,flush=True)


if __name__=='__main__':
    main()
