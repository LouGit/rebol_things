rebol [
	Title:   "Miscellaneous things en rebol"
	Name:    "stupid name: will change in near future"
	Date:    16-Oct-2013/8:39:28+2:00
	Author:  "LouGit"
	License: {
	Copyright (C) 2013 LouGit du Clot
 
    This is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>
    or write to the Free Software Foundation, Inc., 51 Franklin Street, 
    Fifth Floor, Boston, MA 02110-1301, USA.
	}
]

; Rebol lacks a file copy utility
copy-file: func [{Copies file from source to destination. Destination can be a directory or a filename.} source [file!] target [file! url!]] [ ;{{{ } } }
	if (source = target) [alert "Error: source and destination are the same" return none]
	; open source		;o)
	port_source: open/direct/binary/read  to-file source
	if (dir? target) [		; target is a directory: check if a file named like source already exists there
		filename: (second split-path source)
		if ((last (to-string target)) != slash) [append target slash]
		if (exists? to-file rejoin [target file]) [
			if (not (request/confirm rejoin ["Overwrite existing file " target file "?"])) [ return none ]
		]
		target: rejoin [target file]
	]
	if (exists? to-file rejoin [target file]) [
		; file exists!
		if (not (request/confirm rejoin ["Overwrite existing file " target "?"])) [ return none ]
	]
	; solution proposée sur stackoverflow
	port_target: open/direct/binary/write to-file target
	bytes_per: 1024 * 100
	while [not none? data: copy/part port_source bytes_per] [insert port_target data]
	close port_target
	close port_source
	; => oups, pas bon!

]; }}}

