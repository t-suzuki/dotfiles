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
import Tkinter as Tk
import tkMessageBox
import tkFileDialog
import Image, ImageTk

class MainFrame(object, Tk.Frame): # {{{1
	'''main Tk frame'''
	def __init__(self, options, *av, **ak):
		Tk.Frame.__init__(self, *av, **ak)
		self.options = options
		self.init()
	def init(self): # {{{2
		## root frame
		self.master.title(u'test title')
		self.master.geometry('+1400+100')
		self.master.bind('<KeyPress-Escape>', lambda e: self.master.destroy())
		## widgets
		Tk.Button(self, text='open', command=self.open_file).pack()
		Tk.Button(self, text='quit', command=self.master.destroy).pack()
		self.pack()
		# }}}
	def open_file(self): # {{{2
		filename = tkFileDialog.askopenfilename(title=u'select a file')
		tkMessageBox.showinfo(title=u'your selection is:', message=filename)
		image = Image.open(filename)
		self.photoimage = ImageTk.PhotoImage(image) # you must hold this
		imagelabel = Tk.Label(self, image=self.photoimage,
				width=image.size[0], height=image.size[1])
		imagelabel.pack()
		# }}}
	# }}}

def gui_main(options):
	## main frame
	mainframe = MainFrame(options)
	mainframe.mainloop()

def cui_main(options):
	pass

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

	if os.environ.has_key('DISPLAY'):
		gui_main(options)
	else:
		cui_main(options)
	# }}}

if __name__=='__main__':
	main()

# vim: set noet sts=4 ts=4 sw=4 fdm=marker fdl=0:

