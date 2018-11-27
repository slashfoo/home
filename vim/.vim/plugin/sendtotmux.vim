" Copyright 2018 Jamiel Almeida
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.

if exists('g:loaded_sendtotmux')
    finish
endif
" VARIABLES {{{

let s:clipboard_name = 'vim-clipboard-' . getpid()
let s:register = 't'

" VARIABLES }}}
" FUNCTIONS: private {{{

function! <SID>GetParagraph() range
    " Save register
    let l:register_contents = getreg(s:register)
    let l:register_type = getregtype(s:register)

    " Get selection through register
    execute 'silent! normal! vip"' . s:register . 'y'

    let l:selection_text = getreg(s:register)

    " Restore register
    call setreg(s:register, l:register_contents, l:register_type)

    return l:selection_text
endfunction
function! <SID>GetSelection() range
    " Depending on the mode, returns what's been selected. See below.
    "   Mode                What's returned
    "   v                   All the characters that are in the selection
    "   V                   The lines along with line-terminator character for
    "                       all lines
    "   CTRL-V              The lines along with line-terminator character for
    "                       all lines except for the last line which is left
    "                       unterminated
    "   s, S, and CTRL-S    Same as their v-counterparts

    " Save register
    let l:register_contents = getreg(s:register)
    let l:register_type = getregtype(s:register)

    " Get selection through register
    execute 'silent! normal! gv"' . s:register . 'y'

    let l:selection_text = getreg(s:register)

    " Restore register
    call setreg(s:register, l:register_contents, l:register_type)

    return l:selection_text
endfunction

" FUNCTIONS: private }}}
" FUNCTIONS: public {{{

function! sendtotmux#Text(text)
    if $TMUX == ''
        echohl ErrorMsg
        echom "Not running inside tmux. Aborting."
        echohl None
        return
    endif
    call system('tmux load-buffer -b ' . s:clipboard_name . ' -', a:text)
    let l:error = system(
                \ 'tmux paste-buffer -b ' . s:clipboard_name . ' -t "~" 2>&1')
    if v:shell_error != 0
        echohl ErrorMsg
        echo l:error
        echohl None
    endif
endfunction
function! sendtotmux#Selection() range
    let l:text = <SID>GetSelection()

    " Restore selection
    normal! gv

    call sendtotmux#Text(l:text)
endfunction
function! sendtotmux#Line()
    let l:line = getline('.') . "\n"
    call sendtotmux#Text(l:line)
endfunction
function! sendtotmux#Paragraph()
    " Save cursor
    let l:line = line('.')
    let l:col = col('.')

    let l:text = <SID>GetParagraph()

    " Restore cursor
    call cursor(l:line, l:col)

    call sendtotmux#Text(l:text)
endfunction

" FUNCTIONS: public }}}
" MAPPINGS {{{

nnoremap <silent> <Plug>(sendtotmux#line) :call sendtotmux#Line()<CR>
nnoremap <silent> <Plug>(sendtotmux#paragraph) :call sendtotmux#Paragraph()<CR>
xnoremap <silent> <Plug>(sendtotmux#selection) :call sendtotmux#Selection()<CR>

" MAPPINGS }}}

let g:loaded_sendtotmux = 'yup'

" vim: set ft=vim foldmethod=marker foldenable:
