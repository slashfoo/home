" nosat.vim -- a 'no saturation' vim colorscheme
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

if !exists('g:nosat_import') || !g:nosat_import
    set background=dark
    highlight clear
    if exists('syntax_on')
        syntax reset
    endif

    let g:colors_name='nosat'
endif

highlight! clear Normal
highlight!       Normal                         ctermfg=NONE ctermbg=NONE cterm=NONE           guifg=#AAAAAA guibg=NONE    gui=NONE
if has('gui_running') || (exists('g:nosat_transparent_bg') && !g:nosat_transparent_bg)
    " to have an opaque background set the variable g:nosat_transparent_bg to a
    " falsy value, like 0 or an empty string
    highlight! Normal ctermbg=236 guibg=#303030
endif

" UI Elements {{{

" Cursor and Selections {{{

highlight! clear Cursor
highlight!       Cursor                         ctermfg=NONE ctermbg=NONE cterm=NONE           guifg=bg      guibg=fg      gui=NONE
highlight! clear lCursor
highlight! link  lCursor                        Cursor
highlight! clear CursorIM
highlight! link  CursorIM                       Cursor

highlight! clear CursorLine
highlight!       CursorLine                     ctermfg=NONE ctermbg=235  cterm=NONE           guifg=NONE    guibg=#262626 gui=NONE
highlight! clear CursorLineNr
highlight!       CursorLineNr                   ctermfg=245  ctermbg=235  cterm=bold           guifg=#8A8A8A guibg=#262626 gui=bold
highlight! clear CursorColumn
highlight! link  CursorColumn                   CursorLine
highlight! clear MatchParen
highlight!       MatchParen                     ctermfg=160  ctermbg=NONE cterm=bold           guifg=#FF0000 guibg=NONE    gui=bold

highlight! clear Visual
highlight!       Visual                         ctermfg=NONE ctermbg=233  cterm=bold           guifg=NONE    guibg=#121212 gui=bold
highlight! clear VisualNOS
highlight! link  VisualNOS                      Visual

" }}}
" Gutter and ColorColumn {{{

highlight! clear LineNr
highlight!       LineNr                         ctermfg=245  ctermbg=236  cterm=NONE           guifg=#8A8A8A guibg=#303030 gui=NONE
highlight! clear ColorColumn
highlight! link  ColorColumn                    CursorLine
highlight! clear FoldColumn
highlight! clear SignColumn
highlight!       SignColumn                     ctermfg=NONE ctermbg=236  cterm=NONE           guifg=NONE    guibg=#303030 gui=NONE

" }}}
" Window Separators and Bars {{{

highlight! clear StatusLine
highlight!       StatusLine                     ctermfg=237  ctermbg=007  cterm=bold           guifg=#333333 guibg=#CCCCCC gui=bold
highlight! clear StatusLineNC
highlight!       StatusLineNC                   ctermfg=007  ctermbg=237  cterm=bold           guifg=#CCCCCC guibg=#333333 gui=bold
highlight! clear VertSplit
highlight! link  VertSplit                      StatusLineNC

highlight! clear TabLine
highlight! clear TabLineSel
highlight!       TablineSel                     ctermfg=NONE ctermbg=NONE cterm=reverse        guifg=NONE    guibg=NONE    gui=reverse
highlight! clear TabLineFill

highlight! clear Pmenu
highlight!       Pmenu                          ctermfg=NONE ctermbg=233  cterm=NONE           guifg=NONE    guibg=#121212 gui=NONE
highlight! clear PmenuSel
highlight!       PmenuSel                       ctermfg=007  ctermbg=NONE cterm=bold           guifg=#CCCCCC guibg=NONE    gui=bold
highlight! clear PmenuSbar
highlight!       PmenuSbar                      ctermfg=NONE ctermbg=237  cterm=NONE           guifg=NONE    guibg=#3A3A3A gui=NONE
highlight! clear PmenuThumb
highlight!       PmenuThumb                     ctermfg=NONE ctermbg=242  cterm=NONE           guifg=#6C6C6C guibg=NONE    gui=NONE
highlight! clear WildMenu
highlight! link  WildMenu                       PmenuSel

" }}}
" Concealed and Special Characters {{{

highlight! clear Conceal
highlight!       Conceal                        ctermfg=160  ctermbg=NONE cterm=bold           guifg=#FF0000 guibg=NONE    gui=bold
highlight! clear Folded
highlight!       Folded                         ctermfg=245  ctermbg=NONE cterm=reverse        guifg=#8A8A8A guibg=NONE    gui=reverse
highlight! clear NonText
highlight!       NonText                        ctermfg=245  ctermbg=NONE cterm=NONE           guifg=#8A8A8A guibg=NONE    gui=bold
highlight! clear EndOfBuffer
highlight! link  EndOfBuffer                    NonText
highlight! clear SpecialKey
highlight! link  SpecialKey                     NonText

" }}}
" Messages {{{

highlight! clear ModeMsg
highlight!       ModeMsg                        ctermfg=NONE ctermbg=NONE cterm=bold           guifg=NONE    guibg=NONE    gui=bold
highlight! clear MoreMsg
highlight!       MoreMsg                        ctermfg=NONE ctermbg=NONE cterm=bold           guifg=NONE    guibg=NONE    gui=bold
highlight! clear WarningMsg
highlight!       WarningMsg                     ctermfg=003  ctermbg=NONE cterm=NONE           guifg=#DBA656 guibg=NONE    gui=NONE
highlight! clear ErrorMsg
highlight!       ErrorMsg                       ctermfg=001  ctermbg=NONE cterm=NONE           guifg=#BF5D5A guibg=NONE    gui=NONE
highlight! clear Question
highlight!       Question                       ctermfg=NONE ctermbg=NONE cterm=bold           guifg=NONE    guibg=NONE    gui=bold
highlight! clear Title
highlight!       Title                          ctermfg=NONE ctermbg=NONE cterm=bold           guifg=NONE    guibg=NONE    gui=bold

" }}}

" }}}
" Search {{{

highlight! clear Search
highlight!       Search                         ctermfg=012  ctermbg=NONE cterm=reverse        guifg=#85DDFA guibg=NONE    gui=reverse
highlight! clear IncSearch
highlight!       IncSearch                      ctermfg=011  ctermbg=NONE cterm=reverse        guifg=#F7CB88 guibg=NONE    gui=reverse

" }}}
" Diff-ing {{{

highlight! clear DiffAdd
highlight!       DiffAdd                        ctermfg=002  ctermbg=233  cterm=NONE           guifg=#A1B56C guibg=#121212 gui=NONE
highlight! clear DiffChange
highlight!       DiffChange                     ctermfg=003  ctermbg=233  cterm=NONE           guifg=#DBA656 guibg=#121212 gui=NONE
highlight! clear DiffDelete
highlight!       DiffDelete                     ctermfg=052  ctermbg=233  cterm=reverse        guifg=#330000 guibg=#121212 gui=reverse
highlight! clear DiffText
highlight!       DiffText                       ctermfg=222  ctermbg=233  cterm=bold           guifg=#EEDDAA guibg=#121212 gui=bold

" }}}
" Spelling {{{

highlight! clear SpellBad
highlight!       SpellBad                       ctermfg=001  ctermbg=233  cterm=undercurl      guifg=#BF5D5A guibg=#121212 gui=undercurl
highlight! clear SpellCap
highlight!       SpellCap                       ctermfg=004  ctermbg=233  cterm=undercurl      guifg=#7CAFC2 guibg=#121212 gui=undercurl
highlight! clear SpellLocal
highlight!       SpellLocal                     ctermfg=005  ctermbg=233  cterm=undercurl      guifg=#BA8BAF guibg=#121212 gui=undercurl
highlight! clear SpellRare
highlight!       SpellRare                      ctermfg=006  ctermbg=233  cterm=undercurl      guifg=#55B4A8 guibg=#121212 gui=undercurl

" }}}
" Listings {{{

highlight! clear Directory
highlight!       Directory                      ctermfg=004  ctermbg=NONE cterm=NONE           guifg=#7CAFC2 guibg=NONE    gui=NONE

" }}}
" Syntax {{{

highlight! clear Boolean
highlight!       Boorlean                       ctermfg=245  ctermbg=NONE cterm=NONE           guifg=#8A8A8A guibg=NONE    gui=NONE
highlight! clear Character
highlight!       Character                      ctermfg=245  ctermbg=NONE cterm=NONE           guifg=#8A8A8A guibg=NONE    gui=NONE
highlight! clear Comment
highlight!       Comment                        ctermfg=242  ctermbg=NONE cterm=NONE           guifg=#6C6C6C guibg=NONE    gui=NONE
highlight! clear Conditional
highlight! clear Constant
highlight!       Constant                       ctermfg=245  ctermbg=NONE cterm=NONE           guifg=#8A8A8A guibg=NONE    gui=NONE
highlight! clear Debug
highlight! clear Delimiter
highlight! clear Error
highlight!       Error                          ctermfg=001  ctermbg=NONE cterm=NONE           guifg=#BF5D5A guibg=NONE    gui=NONE
highlight! clear Exception
highlight! clear Float
highlight!       Float                          ctermfg=245  ctermbg=NONE cterm=NONE           guifg=#8A8A8A guibg=NONE    gui=NONE
highlight! clear Function
highlight! clear Identifier
highlight! clear Ignore
highlight!       Ignore                         ctermfg=242  ctermbg=NONE cterm=NONE           guifg=#6C6C6C guibg=NONE    gui=NONE
highlight! clear Keyword
highlight! clear Label
highlight! clear Macro
highlight! link  Macro                          Comment
highlight! clear Number
highlight!       Number                         ctermfg=245  ctermbg=NONE cterm=NONE           guifg=#8A8A8A guibg=NONE    gui=NONE
highlight! clear Operator
highlight! clear PreCondit
highlight! link  PreCondit                      Comment
highlight! clear PreProc
highlight!       PreProc                        ctermfg=245  ctermbg=NONE cterm=NONE           guifg=#8A8A8A guibg=NONE    gui=NONE
highlight! clear Define
highlight! link  Define                         PreProc
highlight! clear Include
highlight! link  Include                        PreProc
highlight! clear Repeat
highlight! clear Special
highlight!       Special                        ctermfg=008  ctermbg=NONE cterm=NONE           guifg=#828282 guibg=NONE    gui=NONE
highlight! clear SpecialChar
highlight! clear SpecialComment
highlight! clear Statement
highlight!       Statement                      ctermfg=NONE ctermbg=NONE cterm=NONE           guifg=NONE    guibg=NONE    gui=NONE
highlight! clear StorageClass
highlight! clear String
highlight!       String                         ctermfg=245  ctermbg=NONE cterm=NONE           guifg=#8A8A8A guibg=NONE    gui=NONE
highlight! clear StringDelimiter
highlight!       StringDelimiter                ctermfg=245  ctermbg=NONE cterm=NONE           guifg=#8A8A8A guibg=NONE    gui=NONE
highlight! clear StringDelim
highlight! link  StringDelim                    StringDelimiter
highlight! clear Structure
highlight! clear Tag
highlight! clear Todo
highlight!       Todo                           ctermfg=007  ctermbg=NONE cterm=bold,reverse   guifg=#EEEEEE guibg=NONE    gui=bold,reverse
highlight! clear Type
highlight!       Type                           ctermfg=NONE ctermbg=NONE cterm=NONE           guifg=NONE    guibg=NONE    gui=NONE
highlight! clear Typedef
highlight! clear Underlined
highlight!       Underlined                     ctermfg=NONE ctermbg=NONE cterm=underline      guifg=NONE    guibg=NONE    gui=underline

" }}}
" plugins {{{

" ale {{{

highlight! clear ALEErrorSign
highlight! clear ALEWarningSign
highlight! link  ALEErrorSign                   SyntasticError
highlight! link  ALEWarningSign                 SyntasticWarning

" }}}
" exchange {{{

highlight! clear ExchangeRegion
highlight!       ExchangeRegion                 ctermfg=003  ctermbg=NONE cterm=bold           guifg=#F7CB88 guibg=NONE    gui=bold
highlight! clear _exchange_region
highlight! link  _exchange_region               ExchangeRegion

" }}}
" fzf {{{

highlight! clear FzfNormal
highlight!       FzfNormal                      ctermfg=NONE ctermbg=NONE cterm=NONE           guifg=NONE    guibg=NONE    gui=NONE
highlight! clear FzfCurrLine
highlight!       FzfCurrLine                    ctermfg=015  ctermbg=235  cterm=NONE           guifg=#EEEEEE guibg=#262626 gui=NONE
highlight! clear FzfMatch
highlight!       FzfMatch                       ctermfg=002  ctermbg=NONE cterm=NONE           guifg=#A1B56C guibg=NONE    gui=NONE
highlight! clear FzfMatchCurrLine
highlight!       FzfMatchCurrLine               ctermfg=010  ctermbg=NONE cterm=NONE           guifg=#C5DA8B guibg=NONE    gui=NONE
highlight! clear FzfInfo
highlight!       FzfInfo                        ctermfg=004  ctermbg=NONE cterm=NONE           guifg=#7CAFC2 guibg=NONE    gui=NONE
highlight! clear FzfPrompt
highlight! link  FzfPrompt                      FzfInfo
highlight! clear FzfPointer
highlight! link  FzfPointer                     FzfInfo
highlight! clear FzfMarker
highlight! link  FzfMarker                      FzfInfo
highlight! clear FzfSpinner
highlight!       FzfSpinner                     ctermfg=003  ctermbg=NONE cterm=NONE           guifg=#DBA656 guibg=NONE    gui=NONE
highlight! clear FzfHeader
highlight!       FzfHeader                      ctermfg=007  ctermbg=NONE cterm=NONE           guifg=#CCCCCC guibg=NONE    gui=NONE

" }}}
" fugitive {{{

highlight! link diffAdded                       DiffAdd
highlight! link diffRemoved                     DiffDelete

" }}}
" indent-guides {{{
"
highlight! clear IndentGuidesOdd
highlight!       IndentGuidesOdd                ctermfg=NONE ctermbg=238  cterm=NONE           guifg=NONE    guibg=#444444 gui=NONE
highlight! clear IndentGuidesEven
highlight!       IndentGuidesEven               ctermfg=NONE ctermbg=237  cterm=NONE           guifg=NONE    guibg=#3A3A3A gui=NONE

" }}}
" netrw {{{

highlight! clear netrwClassify
highlight!       netrwClassify                  ctermfg=NONE ctermbg=NONE cterm=NONE           guifg=NONE    guibg=NONE    gui=NONE
highlight! clear netrwDir
highlight! link  netrwDir                       Directory
highlight! clear netrwPlain
highlight!       netrwPlain                     ctermfg=NONE ctermbg=NONE cterm=NONE           guifg=NONE    guibg=NONE    gui=NONE
highlight! clear netrwExe
highlight!       netrwExe                       ctermfg=001  ctermbg=NONE cterm=NONE           guifg=#BF5D5A guibg=NONE    gui=NONE
highlight! clear netrwLink
highlight!       netrwLink                      ctermfg=242  ctermbg=NONE cterm=NONE           guifg=#6C6C6C guibg=NONE    gui=NONE
highlight! clear netrwSymLink
highlight!       netrwSymLink                   ctermfg=005  ctermbg=NONE cterm=NONE           guifg=#BA8BAF guibg=NONE    gui=NONE

" }}}
" syntastic {{{

highlight! clear SyntasticError
highlight!       SyntasticError                 ctermfg=001  ctermbg=NONE cterm=NONE           guifg=#BF5D5A guibg=NONE    gui=NONE
highlight! clear SyntasticErrorLine
highlight! link  SyntasticErrorLine             SyntasticError
highlight! clear SyntasticErrorSign
highlight! link  SyntasticErrorSign             SyntasticError
highlight! clear SyntasticStyleError
highlight! link  SyntasticStyleError            SyntasticError
highlight! clear SyntasticStyleErrorLine
highlight! link  SyntasticStyleErrorLine        SyntasticError
highlight! clear SyntasticStyleErrorSign
highlight! link  SyntasticStyleErrorSign        SyntasticError
highlight! clear SyntasticWarning
highlight!       SyntasticWarning               ctermfg=003  ctermbg=NONE cterm=NONE           guifg=#DBA656 guibg=NONE    gui=NONE
highlight! clear SyntasticWarningLine
highlight! link  SyntasticWarningLine           SyntasticWarning
highlight! clear SyntasticWarningSign
highlight! link  SyntasticWarningSign           SyntasticWarning
highlight! clear SyntasticStyleWarning
highlight! link  SyntasticStyleWarning          SyntasticWarning
highlight! clear SyntasticStyleWarningLine
highlight! link  SyntasticStyleWarningLine      SyntasticWarning
highlight! clear SyntasticStyleWarningSign
highlight! link  SyntasticStyleWarningSign      SyntasticWarning

" }}}
" youcompleteme {{{

highlight! clear YcmErrorLine
highlight!       YcmErrorLine                   ctermfg=001  ctermbg=NONE cterm=NONE           guifg=#BF5D5A guibg=NONE    gui=NONE
highlight! clear YcmErrorSection
highlight! link  YcmErrorSection                YcmErrorLine
highlight! clear YcmErrorSign
highlight! link  YcmErrorSign                   YcmErrorLine
highlight! clear YcmWarningLine
highlight!       YcmWarningLine                 ctermfg=003  ctermbg=NONE cterm=NONE           guifg=#DBA656 guibg=NONE    gui=NONE
highlight! clear YcmWarningSection
highlight! link  YcmWarningSection              YcmWarningLine
highlight! clear YcmWarningSign
highlight! link  YcmWarningSign                 YcmWarningLine

" }}}

" }}}
" language specific syntax {{{

" elixir {{{

highlight! clear elixirVariable
highlight! link  elixirVariable                 Statement

" }}}
" lua {{{

highlight! clear luaSpecialTable
highlight! link  luaSpecialTable                Statement

" }}}
" markdown {{{

highlight! clear markdownHeadingDelimiter
highlight! link  markdownHeadingDelimiter       Title
highlight! clear markdownCode
highlight! link  markdownCode                   String
highlight! clear markdownCodeBlock
highlight! link  markdownCodeBlock              markdownCode
highlight! clear markdownCodeDelimiter
highlight! link  markdownCodeDelimiter          markdownCode
highlight! clear markdownBlockquote
highlight! link  markdownBlockquote             Comment
highlight! clear markdownListMarker
highlight! link  markdownListMarker             Identifier
highlight! clear markdownLinkDelimiter
highlight! clear markdownLinkTextDelimiter
highlight! link  markdownLinkTextDelimiter      markdownLinkDelimiter
highlight! clear markdownRule
highlight! link  markdownRule                   Identifier

" polyglot markdown {{{

highlight! clear mkdListItem
highlight! link  mkdListItem                    markdownListMarker
highlight! clear mkdDelimiter
highlight! link  mkdDelimiter                   markdownLinkDelimiter
highlight! clear mkdRule
highlight! link  mkdRule                        markdownRule

" }}}

" }}}
" python {{{

highlight! clear pythonRun
highlight! link  pythonRun                      PreProc
highlight! clear pythonCoding
highlight! link  pythonCoding                   pythonRun
highlight! clear pythonBoolean
highlight! link  pythonBoolean                  Boolean
highlight! clear pythonExceptions
highlight! link  pythonExceptions               Exception
highlight! clear pythonFunction
highlight! link  pythonFunction                 Function
highlight! clear pythonOperator
highlight! link  pythonOperator                 Operator
highlight! clear pythonStatement
highlight! link  pythonStatement                Statement
highlight! clear pythonBuiltinFunc
highlight! link  pythonBuiltinFunc              pythonStatement
highlight! clear pythonBuiltin
highlight! link  pythonBuiltin                  pythonBuiltinFunc
highlight! clear pythonBuiltinObj
highlight! link  pythonBuiltinObj               pythonBuiltinFunc
highlight! clear pythonDecorator
highlight!       pythonDecorator                ctermfg=245  ctermbg=NONE cterm=bold           guifg=#8A8A8A guibg=NONE    gui=NONE
highlight! clear pythonImport
highlight! link  pythonImport                   Include
highlight! clear pythonInclude
highlight! link  pythonInclude                  pythonImport

" }}}
" vim {{{

highlight! clear vimHiAttrib
highlight! link  vimHiAttrib                    Number
highlight! clear vimFgBgAttrib
highlight! link  vimFgBgAttrib                  vimHiAttrib
highlight! clear vimBufnrWarn
highlight! clear vimNotation
highlight! clear vimFold
highlight! clear vimWarn
highlight! clear vimUserAttrbKey

" }}}
" zsh {{{

highlight! clear zshCommands
highlight! link  zshCommands                    Statement
highlight! clear zshDelimiter
highlight! link  zshDelimiter                   zshConditional
highlight! clear zshFunction
highlight! link  zshFunction                    Function
highlight! clear zshHereDoc
highlight! link  zshHereDoc                     zshString
highlight! clear zshJobSpec
highlight! link  zshJobSpec                     Constant
highlight! clear zshKeyword
highlight! link  zshKeyword                     zshCommands
highlight! clear zshOperator
highlight! link  zshOperator                    Operator
highlight! clear zshPrecommand
highlight! link  zshPrecommand                  zshCommands
highlight! clear zshRepeat
highlight! link  zshRepeat                      zshConditional
highlight! clear zshStringDelimiter
highlight! link  zshStringDelimiter             StringDelimiter
highlight! clear zshSubst
highlight! link  zshSubst                       Statement
highlight! clear zshDereferencing
highlight! link  zshDereferencing               zshSubst

" }}}

" }}}

if exists('*lightline#init')
    call lightline#init()
    call lightline#update()
endif

" vim: foldmethod=marker foldenable nowrap colorcolumn=49,62,75,96,110,124
