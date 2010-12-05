#!/usr/bin/python
# -*- coding: utf-8 -*-
# Document: {{{1
# Title: @{@expand('%:t')@}@
# Requirements:
#   Python
# Description: {{{2
#
# }}}
# Author:
# Website:
# History: {{{2
#   @{@strftime('%Y%m%d')@}@:
# }}}
# License: MIT License {{{2
# Copyright (c) @{@strftime('%Y')@}@ <Author>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# }}}
# }}}

import os
import sys
import numpy as N

def main(): # {{{1
    def parse_options():
        from optparse import OptionParser
        parser = OptionParser()
        parser.add_option('-v', '--verbose',
                action='store_true', dest='verbose', default=False,
                help='show verbose messages')
        options, args = parser.parse_args()
        return options, args

    options, args = parse_options()
    print options
    # }}}

if __name__=='__main__':
    main()

# vim: set et sts=4 ts=4 sw=4 fdm=marker fdl=0:
