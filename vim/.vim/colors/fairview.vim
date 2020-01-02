" fairview.vim -- pseudo-generic Vim color scheme
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

if !exists("g:fairview_import") || !g:fairview_import
    set background=dark
    highlight clear
    if exists("syntax_on")
        syntax reset
    endif

    let g:colors_name="fairview"
endif
let s:nosat_file = expand("<sfile>:h:p") . "/nosat.vim"
let g:nosat_import = 1
execute 'source ' . s:nosat_file

highlight!       Comment                        ctermfg=006  ctermbg=NONE cterm=NONE           guifg=#55B4A8 guibg=NONE    gui=NONE
highlight!       Constant                       ctermfg=001  ctermbg=NONE cterm=NONE           guifg=#BF5D5A guibg=NONE    gui=NONE
highlight!       String                         ctermfg=002  ctermbg=NONE cterm=NONE           guifg=#A1B56C guibg=NONE    gui=NONE
highlight!       StringDelimiter                ctermfg=002  ctermbg=NONE cterm=NONE           guifg=#A1B56C guibg=NONE    gui=NONE
highlight!       Function                       ctermfg=011  ctermbg=NONE cterm=NONE           guifg=#F7CB88 guibg=NONE    gui=NONE
highlight!       Statement                      ctermfg=005  ctermbg=NONE cterm=NONE           guifg=#BA8BAF guibg=NONE    gui=NONE
highlight!       PreProc                        ctermfg=004  ctermbg=NONE cterm=NONE           guifg=#7CAFC2 guibg=NONE    gui=NONE
highlight!       Type                           ctermfg=003  ctermbg=NONE cterm=NONE           guifg=#DBA656 guibg=NONE    gui=NONE
highlight! link  Include                        PreProc
highlight! link  Define                         PreProc
highlight! link  Number                         Constant
highlight! link  Boolean                        Constant
highlight! link  Character                      String

" ZSH Specific Highlights {{{

highlight! link  zshConditional                 Statement
highlight! link  zshRepeat                      Statement
highlight! link  zshDelimiter                   Statement
highlight! link  zshCommands                    Statement

" }}}
" Elixir Specific Highlights {{{

highlight!       elixirVariable                 ctermfg=005  ctermbg=NONE cterm=NONE           guifg=#BA8BAF guibg=NONE    gui=NONE
highlight! link  elixirKeyword                  Statement
highlight! link  elixirAlias                    Type

" }}}
" Python Specific Highlights {{{

highlight! link  pythonOperator                 Statement
highlight! link  pythonStatement                Statement
highlight!       pythonRun                      ctermfg=001  ctermbg=NONE cterm=NONE           guifg=#BF5D5A guibg=NONE    gui=NONE

" }}}

" vim: foldmethod=marker foldenable nowrap colorcolumn=49,62,75,96,110,124
