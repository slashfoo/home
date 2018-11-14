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

if exists('g:loaded_showelement')
  finish
endif
let g:loaded_showelement = 1

" Based on http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor

function! showelement#word_under_cursor()
    let l:l = line(".")
    let l:c = col(".")
    let l:sid_hi = synID(l:l, l:c, 1)
    let l:sid_trans = synID(l:l, l:c, 0)
    let l:sid_lo = synIDtrans(l:sid_hi)

    let l:msg = 'hi<'    . synIDattr(l:sid_hi    , 'name') . '>  '
            \ . 'trans<' . synIDattr(l:sid_trans , 'name') . '>  '
            \ . 'lo<'    . synIDattr(l:sid_lo    , 'name') . '>'

    echom l:msg
endfunction
