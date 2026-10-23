"""Local diagnostics only; never imported by a contest submission."""
import inspect


def get_kernel_source(kernel):
    """Read compiled sources without adding attributes to user callables."""
    if inspect.isfunction(kernel):
        captured = inspect.getclosurevars(kernel).nonlocals
        if 'pack' in captured and 'attention' in captured:
            return (get_kernel_source(captured['pack'])
                    + get_kernel_source(captured['attention']))
        if 'prepare' in captured and 'attention' in captured:
            return (get_kernel_source(captured['prepare'])
                    + get_kernel_source(captured['attention']))
    return kernel.get_kernel_source()
