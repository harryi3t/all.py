#!/usr/bin/env python
from copy import *
from caller_module import *
from public import *

IGNORED = ['__builtins__', '__file__', 'modules', '__package__', '__name__', '__doc__']

class AttributeError(AttributeError): pass

@public
def all(module):
    """todo"""
    if not module:
        module = caller_module()
    kwargs = dict()
    if hasattr(module,"__all__"):
        keys = module.__all__
    else:
        keys = module.__dict__.keys()
    for k in keys:
        if k not in IGNORED:
            if k in module.__dict__:
                kwargs[k] = module.__dict__[k]
            else:
                err = "'%s' object has no attribute '%s'" % (module,k)
                raise AttributeError(err)
    return kwargs

