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

" vim: foldmethod=marker
if $RESTARTS_DIR == ''
  finish
endif
if exists('g:loaded_rebinddisplay')
  finish
endif
let g:loaded_rebinddisplay = 1

function! rebinddisplay#restart()
    let $DISPLAY = ''
    let l:restarts_dir = substitute($RESTARTS_DIR, '/$', '', '')
    execute 'mksession! ' . l:restarts_dir . '/restart'
    try
        wqall
    catch /E141:/
        call delete(l:restarts_dir . '/restart')
        echohl ErrorMsg
        echom "Some buffers could not be saved due to being unnamed"
        echohl None
    endtry
endfunction

command! Restart call rebinddisplay#restart()
