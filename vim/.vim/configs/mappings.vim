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

if exists("*showelement#word_under_cursor")
    map <silent> <C-g> :call showelement#word_under_cursor()<CR>
endif
if exists(":Restart")
    nnoremap <silent> <leader>R :Restart<CR>
endif
if exists(':Stabs')
        nnoremap cog :Stabs<CR>
endif
if exists(':Note')
    nmap <Leader>, :Ngrep<Space>
    nmap <Leader>< :Explore <C-R>=g:notes_directory<CR><CR>
    nmap <Leader>; :Note!<Space>
    nmap <Leader>: :Note <C-R>=strftime('%Y%m%d')<CR> pad<CR>
    nmap <Leader>a :Note<Space>
    nmap <Leader>' :Notes<CR>
endif
if exists(':Scratch')
    nmap <Leader>. :Scratch<CR>
    nmap <Leader>> :Sscratch<CR>
endif
if mapcheck('<plug>(interestingwords#resetwords)') != ''
    nmap <silent> <Leader>^ <plug>(interestingwords#resetwords)
    nmap <silent> <Leader>[ <plug>(interestingwords#highlight-cword-0)
    nmap <silent> <Leader>{ <plug>(interestingwords#highlight-cword-1)
    nmap <silent> <Leader>& <plug>(interestingwords#highlight-cword-2)
    nmap <silent> <Leader>( <plug>(interestingwords#highlight-cword-3)
    nmap <silent> <Leader>= <plug>(interestingwords#highlight-cword-4)
    nmap <silent> <Leader>+ <plug>(interestingwords#highlight-cword-5)
    nmap <silent> <Leader>) <plug>(interestingwords#highlight-cword-6)
    nmap <silent> <Leader>* <plug>(interestingwords#highlight-cword-7)
    nmap <silent> <Leader>} <plug>(interestingwords#highlight-cword-8)
    nmap <silent> <Leader>] <plug>(interestingwords#highlight-cword-9)
    nmap <silent> <Leader># <plug>(interestingwords#highlight-cword-10)
    nmap <silent> <Leader>! <plug>(interestingwords#highlight-cword-11)
    xmap <silent> <Leader>^ <plug>(interestingwords#resetwords)
    xmap <silent> <Leader>[ <plug>(interestingwords#highlight-sel-0)
    xmap <silent> <Leader>{ <plug>(interestingwords#highlight-sel-1)
    xmap <silent> <Leader>& <plug>(interestingwords#highlight-sel-2)
    xmap <silent> <Leader>( <plug>(interestingwords#highlight-sel-3)
    xmap <silent> <Leader>= <plug>(interestingwords#highlight-sel-4)
    xmap <silent> <Leader>+ <plug>(interestingwords#highlight-sel-5)
    xmap <silent> <Leader>) <plug>(interestingwords#highlight-sel-6)
    xmap <silent> <Leader>* <plug>(interestingwords#highlight-sel-7)
    xmap <silent> <Leader>} <plug>(interestingwords#highlight-sel-8)
    xmap <silent> <Leader>] <plug>(interestingwords#highlight-sel-9)
    xmap <silent> <Leader># <plug>(interestingwords#highlight-sel-10)
    xmap <silent> <Leader>! <plug>(interestingwords#highlight-sel-11)

    nnoremap <silent> coy :call interestingwords#toggle_syntax()<CR>
endif
if mapcheck('<Plug>(sendtotmux#selection)') != ''
    nmap <silent> <Leader>s <NOP>
    xmap <Leader>ss <Plug>(sendtotmux#selection)
    nmap <Leader>ss <Plug>(sendtotmux#line)
    nmap <Leader>sp <Plug>(sendtotmux#paragraph)
endif
" vim: foldmethod=marker foldenable
