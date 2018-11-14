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

if exists('g:loaded_stab')
  finish
endif
let g:loaded_stab = 1

" Set tabstop, softtabstop and shiftwidth to the same value
" Based on the function on the same name by Drew Neil as exposed on:
" http://vimcasts.org/episodes/tabs-and-spaces/

function! stab#set_tabs(number)
    let l:tabstop = a:number
    if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
    endif
    call stab#summarize_tabs()
endfunction

" http://vimcasts.org/episodes/tabs-and-spaces/
function! stab#summarize_tabs()
    let l:msg = 'tabstop=' . &l:ts
            \ . ' shiftwidth=' . &l:sw
            \ . ' softtabstop=' . &l:sts
    if &l:et
        let l:msg.=' expandtab'
    else
        let l:msg.=' noexpandtab'
    endif
    echom l:msg
endfunction

command! -nargs=1 Stab call stab#set_tabs(<args>)
command! -nargs=0 Stabs call stab#summarize_tabs()
