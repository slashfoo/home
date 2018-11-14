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

if exists('g:loaded_nonascii')
  finish
endif
let g:loaded_nonascii = 1

highlight! clear NonAscii
highlight! NonAscii ctermfg=001 ctermbg=NONE cterm=NONE guifg=#BF5D5A guibg=NONE gui=NONE
if has("autocmd")
    augroup nonascii
        autocmd!
        " Highlight non-printable characters not included in listchars
        autocmd VimEnter * match NonAscii '\v[^\x00-\x7F]'
    augroup end
endif
