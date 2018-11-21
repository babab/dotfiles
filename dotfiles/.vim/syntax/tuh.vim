" Vim syntax file for Tuhinga
" Language: Tuhinga
" Maintainer: Benjamin Althues
" Latest Revision: Dec 28 2014

" Copyright (c) 2014-2015 Benjamin Althues <benjamin@babab.nl>
"
" Permission to use, copy, modify, and distribute this software for any
" purpose with or without fee is hereby granted, provided that the above
" copyright notice and this permission notice appear in all copies.
"
" THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
" WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
" MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
" ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
" WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
" ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
" OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


if exists("b:current_syntax")
    finish
endif

syn keyword tuhTodo contained TODO FIXME XXX NOTE
syn match tuhComment /;.*$/ contains=tuhTodo

syn match tuhElement contained /^\s*[a-zA-Z0-9-]*/ skipwhite
syn match tuhId contained /#[a-zA-Z0-9-]*/ skipwhite
syn match tuhClass contained /\.[a-zA-Z0-9-]*/ skipwhite
syn match tuhArgument contained /[^\\]:[a-zA-Z0-9-=]*/ skipwhite

syn region tuhDocument start=/^[^;]/ end=/$/ transparent
            \ contains=tuhElement,tuhId,tuhClass,tuhArgument


let b:current_syntax = "tuh"

hi def link tuhTodo         Todo
hi def link tuhComment      Comment
hi def link tuhElement      Statement
hi def link tuhId           Identifier
hi def link tuhClass        Type
hi def link tuhArgument     Constant
hi def link tuhSpecial      Todo
