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

scriptencoding utf-8

" Setting list of plugins to install with vim-plug {{{

" Plugin libraries and utils
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'

" General / Utility
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer --rust-completer --java-completer --tern-completer' }
Plug 'ron89/thesaurus_query.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'bronson/vim-visual-star-search'
Plug 'epeli/slimux'
Plug 'google/vim-codefmt'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'

if executable('fzf')
    " Only load fzf plugins if we have the executable installed
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
endif
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'mbbill/undotree', { 'on': ['UndotreeToggle'] }
Plug 'rking/ag.vim'
Plug 'romainl/vim-qf'
Plug 'w0rp/ale'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/timestamp.vim'
Plug 'junegunn/vim-easy-align'
Plug 'bazelbuild/vim-bazel'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'andrewradev/splitjoin.vim'

" Text objects
Plug 'b4winckler/vim-angry'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-user'
Plug 'saihoooooooo/vim-textobj-space'

" Languages
Plug 'plasticboy/vim-markdown'
Plug 'nelstrom/vim-subrip'
Plug 'rust-lang/rust.vim'
Plug 'mattn/emmet-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'buoto/gotests-vim', {'do': 'go get -v github.com/cweill/gotests/gotests'}

" Putting vim-polyglot at the end to wor around a vim-go bug.
" Bug URL: https://github.com/fatih/vim-go/issues/2045#issuecomment-437197496
Plug 'sheerun/vim-polyglot'

" }}}
" Helper Functions {{{

function! <SID>toggle_timestamp()
    if !exists('b:timestamp_disabled')
        let b:timestamp_disabled = 1
        echohl WarningMsg
        echom 'Local timestamping disabled'
        echohl None
    else
        unlet b:timestamp_disabled
        echohl WarningMsg
        echom 'Local timestamping enabled'
        echohl None
    endif
endfunction

" }}}
" Plugin configs {{{

function! ext_plugin_settings#set_variables()
    " ag {{{
    if $AG_IGNORE != ''
        let g:ag_prg='ag --depth=20 --path-to-ignore ' . $AG_IGNORE . ' --follow --hidden --skip-vcs-ignores --vimgrep --smart-case'
    endif
    let g:ag_highlight=0
    let g:ag_apply_lmappings=0
    let g:ag_apply_qmappings=0
    let g:ag_mapping_message=0
    " }}}
    " ale {{{
    let g:ale_linters = {
                \ 'typescript': [],
                \ 'python': ['pylint'],
                \ }
    let g:ale_sign_error = '✘ '
    let g:ale_sign_warning = '⚠ '

    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_enter = 0

    if executable('gpylint')
        let g:ale_python_pylint_executable = 'gpylint'
    endif

    if executable('gofmt')
        let g:go_gofmt_executable = 'gofmt'
    elseif executable('goimports')
        let g:go_gofmt_executable = 'goimports'
    endif

    " }}}
    " auto-pairs {{{
    let g:AutoPairsMoveCharacter = ''
    let g:AutoPairsShortcutToggle = ''
    let g:AutoPairsShortcutFastWrap = ''
    let g:AutoPairsShortcutJump = ''
    let g:AutoPairsShortcutBackInsert = ''
    " }}}
    " fzf {{{
    let g:fzf_layout = { 'down': '~80%' }
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Function'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'String'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
    " }}}
    " indent-guides {{{
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 0
    let g:indent_guides_default_mapping = 0
    let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
    if &shiftwidth >= 4
        let g:indent_guides_guide_size = 0
    else
        let g:indent_guides_guide_size = 1
    endif
    let g:indent_guides_indent_levels = 5
    let g:indent_guides_start_level = 1
    " }}}
    " Lightline {{{
    let g:lightline = {
        \ 'colorscheme': 'nosat',
        \ 'active': {
        \     'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
        \     'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'inactive': {
        \     'left': [
        \           ['relativepath', 'modified']
        \     ],
        \     'right': [
        \           ['lineinfo'], ['percent'], [ 'filetype' ]
        \     ],
        \ },
        \ 'tabline': {
        \     'left': [
        \         ['tabs']
        \     ],
        \     'right': []
        \ },
        \ 'component': {
        \     'paste': '%{&paste?"!":""}',
        \     'readonly': '%{&readonly?"":""}',
        \     'lineinfo': '%4l:%-3v',
        \     'relativepath': '%-.34f',
        \ },
        \ 'component_function': {
        \     'fileformat': 'LightlineFileformat',
        \     'fileencoding': 'LightlineFileencoding',
        \ },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
        \ }

    let g:lightline.mode_map = {
        \ 'n'      : ' N ',
        \ 'i'      : ' I ',
        \ 'R'      : ' R ',
        \ 'v'      : ' V ',
        \ 'V'      : 'V-L',
        \ "\<C-v>" : 'V-B',
        \ 'c'      : ' C ',
        \ 's'      : ' S ',
        \ 'S'      : 'S-L',
        \ "\<C-s>" : 'S-B',
        \ 't'      : ' T ' }

    function! LightlineFileencoding()
        return winwidth(0) > 70 ? &fileencoding : ''
    endfunction

    function! LightlineFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    let g:lightline#colorscheme#nosat#palette = {
    \   'tabline': {
    \       'left':     [['#808080', '#3A3A3A', 244, 237]],
    \       'middle':   [['#808080', '#3A3A3A', 244, 237]],
    \       'right':    [['#3A3A3A', '#808080', 237, 244], ['#A8A8A8', '#585858', 248, 240]],
    \       'tabsel':   [['#DADADA', '#585858', 253, 240]]
    \   },
    \   'inactive': {
    \       'left':     [['#DADADA', '#3A3A3A', 253, 237], ['#6C6C6C', '#3A3A3A', 242, 237]],
    \       'middle':   [['#6C6C6C', '#3A3A3A', 242, 237]],
    \       'right':    [['#DADADA', '#6C6C6C', 253, 242], ['#DADADA', '#3A3A3A', 253, 237]]
    \   },
    \   'normal': {
    \       'left':     [['#3A3A3A', '#7CAFC2', 237, 004], ['#DADADA', '#585858', 253, 240]],
    \       'middle':   [['#DADADA', '#3A3A3A', 253, 237]],
    \       'right':    [['#DADADA', '#6C6C6C', 253, 242], ['#DADADA', '#585858', 253, 240]],
    \       'warning':  [['#DBA656', '#585858', 003, 240]],
    \       'error':    [['#BF5D5A', '#3A3A3A', 001, 237]]
    \   },
    \   'insert': {
    \       'left':     [['#3A3A3A', '#DBA656', 237, 003], ['#DADADA', '#4E4E43', 253, 240]]
    \   },
    \   'visual': {
    \       'left':     [['#3A3A3A', '#BF5D5A', 237, 001], ['#DADADA', '#4E4E43', 253, 240]]
    \   },
    \   'replace': {
    \       'left':     [['#3A3A3A', '#BA8BAF', 237, 005], ['#DADADA', '#4E4E43', 253, 240]]
    \   },
    \   'terminal': {
    \       'left':     [['#3A3A3A', '#55B4A8', 237, 006], ['#DADADA', '#4E4E43', 253, 240]]
    \   }
    \ }
    " }}}
    " netrw {{{
    let g:netrw_bufsettings = ''
    let g:netrw_bufsettings .= 'nomodifiable nomodified nonumber '
    let g:netrw_bufsettings .= 'nobuflisted nowrap readonly '
    let g:netrw_bufsettings .= 'norelativenumber signcolumn=no'
    let g:netrw_browsex_viewer = 'browser-work'
    " }}}
    " markdown {{{
    let g:vim_markdown_folding_style_pythonic = 1
    let g:vim_markdown_conceal = 1
    let g:vim_markdown_frontmatter = 1
    let g:vim_markdown_toml_frontmatter = 1
    let g:vim_markdown_json_frontmatter = 1
    let g:vim_markdown_math = 1
    let g:vim_markdown_no_extensions_in_markdown = 1
    " }}}
    " polyglot {{{
    let g:python_highlight_all = 1
    let g:polyglot_disabled = ['markdown', 'go']
    " }}}
    " slimux {{{
    if $PREFERRED_TMUX !=# ''
        let g:slimux_tmux_path = $PREFERRED_TMUX
    endif
    let g:slimux_always_use_marked = 1
    let g:slimux_buffer_filetype = 'cfg'
    let g:slimux_pane_hint_map = 'dd'
    let g:slimux_exclude_vim_pane = 0
    let g:slimux_select_from_current_window = 0
    let g:slimux_exclude_other_sessions = 0
    let g:slimux_restore_selection_after_visual = 0
    " }}}
    " tagbar {{{
    let g:tagbar_autofocus = 1
    let g:tagbar_compact = 1
    let g:tagbar_map_showproto = ''
    " }}}
    " scriptease {{{

    let g:scriptease_iskeyword = 0

    " }}}
    " thesaurus_query {{{
    let g:tq_mthesaur_file = $MYVIMDIR . '/spell/mthesaur.txt'
    let g:tq_enabled_backends = ['thesaurus_com', 'mthesaur_txt']
    let g:tq_online_backends_timeout = 0.6
    let g:tq_language = ['en']
    let g:tq_map_keys = 0
    " }}}
    " timestamp {{{
    let g:timestamp_regexp = '\v\C%(<%(Last %([cC]hanged?|[mM]odified|[uU]pdated)|[uU]pdated)\s*:\s+)@<=.*$'
    " TODO: one day...
    " I'll try to make it so that auto-timestamps are in format:
    " %Y-%m-%dT%H:%M:%S%:z
    let g:timestamp_rep = '%Y-%m-%dT%H:%M:%S%z'
    let g:timestamp_modelines = 10
    " }}}
    " ultisnips {{{
    " F32 is Control+Tab, urxvt is configured to send \033[50~ and this is set
    " in vimrc to mean F32
    let g:UltiSnipsListSnippets = '<F50>'
    let g:UltiSnipsExpandTrigger = '<Tab>'
    let g:UltiSnipsJumpForwardTrigger = '<Tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit='normal'
    let g:UltiSnipsSnippetsDir = $MYVIMDIR . '/templates'
    let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir]

    let g:snips_author='Jamiel Almeida'
    let g:snips_email='jamiel.almeida@gmail.com'
    let g:snips_github='https://github.com/slashfoo'
    " }}}
    " undotree {{{
    let g:undotree_SetFocusWhenToggle = 1
    " }}}
    " vim-go {{{
    let g:go_auto_sameids = 1
    let g:go_def_mapping_enabled = 0
    let g:go_fmt_autosave = 0
    let g:go_mod_fmt_autosave = 0
    let g:go_template_autocreate = 0
    let g:go_textobj_include_function_doc = 1
    let g:go_textobj_include_variable = 1
    let g:go_updatetime = 0
    if has('nvim')
        let g:go_term_enabled = 0
        let g:go_term_height = 10
        let g:go_term_mode = "split"
    endif
    " }}}
    " vim-qf {{{
    let g:qf_mapping_ack_style = 1
    let g:qf_auto_quit = 0
    " }}}
    " youcompleteme {{{
    let g:ycm_global_ycm_extra_conf=$MYVIMDIR . '/ycm_extra_conf.py'
    let g:ycm_server_python_interpreter = 'python'
    let g:ycm_min_num_of_chars_for_completion = 1
    let g:ycm_autoclose_preview_window_after_completion=1
    let g:ycm_complete_in_comments = 1
    let g:ycm_complete_in_strings = 1
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_seed_identifiers_with_syntax = 0
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:ycm_key_invoke_completion = '<C-X><C-X>'
    let g:ycm_key_detailed_diagnostics = ''
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_use_ultisnips_completer = 1
    let g:ycm_auto_trigger = 1
    let g:ycm_add_preview_to_completeopt=0
    " }}}
endfunction
function! ext_plugin_settings#set_variables_postcommands()
    " vim-codefmt {{{
    if exists(':Glaive')
        Glaive vim-codefmt gofmt_executable="goimports"
    endif
    " }}}
endfunction
function! ext_plugin_settings#set_commands()
    augroup ext_plugins
        autocmd!
        " youcompleteme {{{
        autocmd FileType typescript
                      \  if exists('g:loaded_youcompleteme')
                      \|    nnoremap <Leader>g :YcmCompleter GoToDefinition<CR>
                      \| endif
        " }}}
        " fzf {{{
        autocmd  FileType fzf set laststatus=0 noshowmode noruler
                 \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
        " }}}
        " vim-go {{{
        autocmd Filetype goterm nmap <buffer> <Leader><Space> <C-w>c
        autocmd Filetype godoc nmap <buffer> <Leader><Space> <C-w>c
        " }}}
        " ALL {{{
        autocmd VimEnter *
                    \ call ext_plugin_settings#set_variables_postcommands()
        " }}}
    augroup end
endfunction
function! ext_plugin_settings#set_mappings()
    " vim-codefmt {{{
    if exists(':FormatCode')
        function! <SID>format_code_in_buffer()
            if codefmt#IsFormatterAvailable()
                call codefmt#FormatBuffer()
            else
                call VimRC_FormatBuffer()
            endif
        endfunction
        function! <SID>format_code_in_lines()
            if codefmt#IsFormatterAvailable()
                call codefmt#FormatLines(line("'<"), line("'>"))
            else
                execute "normal! gv=gv"
            endif
        endfunction
        nnoremap <silent> <F35> :call <SID>format_code_in_buffer()<CR>
        xnoremap <silent> <F35> :call <SID>format_code_in_lines()<CR>
    endif
    " }}}
    " characterize {{{
    nmap gA <Plug>(characterize)
    " }}}
    " easy-align {{{
    if exists(':EasyAlign')
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
    endif
    " }}}
    " fzf {{{
    if exists(':Files')
        nmap <silent> <leader><tab> <plug>(fzf-maps-n)
        xmap <silent> <leader><tab> <plug>(fzf-maps-x)
        omap <silent> <leader><tab> <plug>(fzf-maps-o)
        nnoremap <silent> <C-p><C-p> :Files <C-r>=getcwd()<CR><CR>
        nnoremap <silent> <C-p><C-f> :Files <C-r>=expand('%:p:h')<CR><CR>
        nnoremap <silent> <C-p><C-h> :Files <C-r>=expand('~')<CR><CR>
        nnoremap <C-p>p :Files <C-r>=getcwd()<CR>/
        nnoremap <C-p>f :Files <C-r>=expand('%:p:h')<CR>/
        nnoremap <C-p>h :Files <C-r>=expand('~')<CR>/
        nnoremap <silent> <C-n> :Buffers<CR>
        imap <silent> <C-x><C-w> <plug>(fzf-complete-word)
        inoremap <silent> <F2> <C-C>:History<CR>
        nnoremap <silent> <F2> :History<CR>
        vnoremap <silent> <F2> :<C-u>History<CR>
    endif
    " }}}
    " indent-guides {{{
    if exists(':IndentGuidesToggle')
        nmap <silent> coi :IndentGuidesToggle<CR>
    endif
    " }}}
    " slimux {{{
    if exists(':SlimuxREPLConfigure')
        xmap <silent> <Leader>ss :SlimuxREPLSendSelection<CR>
        nmap <silent> <Leader>ss :SlimuxREPLSendLine<CR>
        nmap <silent> <Leader>sp :SlimuxREPLSendParagraph<CR>
        nmap <silent> <Leader>s <NOP>

        nmap <Leader>sg :SlimuxGlobalConfigure<CR>
        xmap <Leader>sg :<C-u>SlimuxGlobalConfigure<CR>
        nmap <Leader>sr :SlimuxREPLConfigure<CR>
        nmap <Leader>sh :SlimuxShellConfigure<CR>
        nmap <Leader>sk :SlimuxSendKeysConfigure<CR>

        " F36 is Meta+Enter (Alt+Enter), urxvt is configured to send \033[48~
        " and this is set in vimrc to mean F36
        nnoremap <silent> <F36> :update<CR>:SlimuxSendKeys C-j<CR>
        inoremap <silent> <F36> <C-o>:update<CR><C-o>:SlimuxSendKeys C-j<CR>
    endif
    " }}}
    " tagbar {{{
    if exists(':TagbarToggle')
        nnoremap cot :TagbarToggle<CR>
        inoremap <F8> <C-C>:TagbarToggle<CR>
        nnoremap <F8> :TagbarToggle<CR>
        vnoremap <F8> :<C-U>:TagbarToggle<CR>
    endif
    " }}}
    " thesaurus_query {{{
    nnoremap <Leader>t :ThesaurusQueryReplaceCurrentWord<CR>
    vnoremap <Leader>t "ky:ThesaurusQueryReplace <C-r>k<CR>
    " }}}
    " timestamp {{{
    if exists(':DisableTimestamp')
        inoremap <silent> <F4> <C-O>:call <SID>toggle_timestamp()<CR>
        nnoremap <silent> <F4> :call <SID>toggle_timestamp()<CR>
        vnoremap <silent> <F4> :<C-U>call <SID>toggle_timestamp()<CR>
    endif
    " }}}
    " undotree {{{
    if exists(':UndotreeToggle')
        nnoremap coz :UndotreeToggle<CR>
        inoremap <F1> <C-C>:UndotreeToggle<CR>
        nnoremap <F1> :UndotreeToggle<CR>
        vnoremap <F1> :<C-U>:UndotreeToggle<CR>
    endif
    " }}}
    " ultisnips {{{
    if exists(':UltiSnipsEdit')
        nnoremap <Leader>eu :UltiSnipsEdit<CR>
        if exists(':Snippets')
            nnoremap <F32> :Snippets<CR>
            imap <F32> <C-o>:Snippets<CR>
        else
            nnoremap <F32> :call UltiSnips#ListSnippets()<CR>
            let g:UltiSnipsListSnippets = '<F32>'
        endif
    endif
    " }}}
    " visual-star-search {{{
    if exists('*VisualStarSearchSet')
        xnoremap * :<C-u>let w:saved_view = winsaveview()<CR>
                    \gv:<C-u>call VisualStarSearchSet('/')<CR>/
                    \<C-R>=@/<CR><CR>:
                    \call winrestview(w:saved_view)<CR>:echo<CR>gv
        xnoremap # :<C-u>let w:saved_view = winsaveview()<CR>g
                    \v:<C-u>call VisualStarSearchSet('?')<CR>?
                    \<C-R>=@/<CR><CR>:
                    \call winrestview(w:saved_view)<CR>:echo<CR>gv
    endif
    " }}}
    " youcompleteme {{{
    if exists( 'g:loaded_youcompleteme' )
        if (&ft == 'typescript') || (&ft =~ 'javascript')
            nnoremap <Leader>g :YcmCompleter GoToDefinition<CR>
        else
            nnoremap <Leader>g :YcmCompleter GoTo<CR>
        endif
        nnoremap <Leader>x :YcmCompleter GoToReferences<CR>
        nnoremap <Leader>d :YcmCompleter GetDoc<CR>
    endif
    " }}}
endfunction

" }}}

" vim: foldmethod=marker foldenable
