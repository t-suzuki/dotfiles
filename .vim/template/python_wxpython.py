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
import wx
import Image

class MainFrame(wx.Frame): # {{{1
	'''main wx frame'''
	def __init__(self, options, *av, **ak):
		super(MainFrame, self).__init__(None, *av, **ak)
		self.options = options
		self.init()
	def init(self): # {{{2
		## root frame
		self.CreateStatusBar()
		self.SetStatusText(u'ステータスバー')
		self.SetTitle(u'タイトル')
		self.SetPosition((1400, 100))
		## widgets
		hsizer = wx.BoxSizer(wx.HORIZONTAL)
		b = wx.Button(self, -1, u'open')
		b.Bind(wx.EVT_BUTTON, self.open_file)
		hsizer.Add(b)
		b = wx.Button(self, -1, u'quit')
		b.Bind(wx.EVT_BUTTON, lambda x: self.Destroy())
		hsizer.Add(b)
		self.SetSizer(hsizer)
		# }}}
	def open_file(self, ev): # {{{2
		fdlg = wx.FileDialog(self)
		if fdlg.ShowModal() == wx.ID_OK:
			s = wx.StaticText(self, -1, fdlg.Filename)
			self.GetSizer().Add(s)
			image = Image.open(fdlg.Filename)
			image_wx = apply(wx.EmptyImage, image.size)
			image_wx.SetData(image.convert('RGB').tostring())
			s = wx.StaticBitmap(self, -1, image_wx.ConvertToBitmap(), (0,0), image.size)
			self.GetSizer().Add(s)
			self.GetSizer().Fit(self)
		# }}}
	# }}}

def gui_main(options):
	## main frame
	app = wx.App()
	mainframe = MainFrame(options)
	mainframe.Show(True)
	app.MainLoop()

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

