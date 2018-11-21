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

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

setlocal nolist
setlocal autowrite
setlocal noexpandtab
setlocal shiftwidth=4 softtabstop=4 tabstop=4

nmap <buffer> <F36> <Plug>(go-build)
nmap <buffer> <F37> <Plug>(go-run)
nmap <buffer> <Leader>d <Plug>(go-doc)
nmap <buffer> <Leader>D <Plug>(go-doc)
nmap <buffer> <Leader>t <Plug>(go-test)
nmap <buffer> <Leader>T <Plug>(go-test-func)
nmap <buffer> <Leader>g <Plug>(go-def)
nmap <buffer> <Leader>x <Plug>(go-callees)
nmap <buffer> <Leader>X <Plug>(go-caller)

nnoremap <buffer> <Leader>ea :GoAlternate!<CR>
nnoremap <buffer> <Leader>ed :GoDecls<CR>
nnoremap <buffer> <Leader>eD :GoDeclsDir<CR>
nnoremap <buffer> <Leader>u :GoCoverageToggle<CR>

nnoremap <buffer> <Leader>A :GoAddTags
nnoremap <buffer> <Leader>A- :GoRemoveTags<Space>
nnoremap <buffer> <Leader>Aj :GoAddTags json<CR>
nnoremap <buffer> <Leader>Ay :GoAddTags yaml<CR>
nnoremap <buffer> <Leader>Ax :GoAddTags xml<CR>

xnoremap <buffer> <Leader>A :GoAddTags
xnoremap <buffer> <Leader>A- :GoRemoveTags<Space>
xnoremap <buffer> <Leader>Aj :GoAddTags json<CR>
xnoremap <buffer> <Leader>Ay :GoAddTags yaml<CR>
xnoremap <buffer> <Leader>Ax :GoAddTags xml<CR>

if executable('gotags')
    let g:tagbar_type_go = {
        \   'ctagstype' : 'go',
        \   'kinds'     : [
        \       'p:package',
        \       'i:imports',
        \       'c:constants',
        \       'v:variables',
        \       't:types',
        \       'n:interfaces',
        \       'w:fields',
        \       'e:embedded',
        \       'm:methods',
        \       'r:constructor',
        \       'f:functions'
        \   ],
        \   'sro' : '.',
        \   'kind2scope' : {
        \       't' : 'ctype',
        \       'n' : 'ntype'
        \   },
        \   'scope2kind' : {
        \       'ctype' : 't',
        \       'ntype' : 'n'
        \   },
        \   'ctagsbin'  : 'gotags',
        \   'ctagsargs' : '-sort -silent'
        \ }
endif
if exists(":AutoFormatBuffer")
    AutoFormatBuffer gofmt
endif
