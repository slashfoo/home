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

" This plugin was based on Steve Losh's idea of highlighting interesting words
" which he mini-pluginized in his vimrc file
"
" You can check his implementation of it here:
" https://bitbucket.org/sjl/dotfiles/src/e2a961f1d037e53ea2809885a65feba66a9aa03e/vim/vimrc?at=default&fileviewer=file-view-default#vimrc-3009:3060
"
" Here I'm implementing what amounts to be a weaponized version of that
" functionality in a way that makes sense for my every-day use.

if exists('g:loaded_interestingwords')
  finish
endif
let g:loaded_interestingwords = 1

" private/auxiliary functions {{{

function! <SID>get_selection()
    let [l:line1, l:offset1] = getpos("'<")[1:2]
    let [l:line2, l:offset2] = getpos("'>")[1:2]
    let l:selection_lines = getline(l:line1, l:line2)

    " because of multibyte characters, I have to do this ugly hack
    " Get what the character under the cursor is
    let l:last_character = matchstr(l:selection_lines[-1],
                \ '\%' . l:offset2 . 'c.')

    " If the cursor is on the first column of the line, the line is only that
    " one character, otherwise...

    if l:offset2 == 1
        let l:selection_lines[-1] = l:last_character
    else
        " make the last line the line up to the byte before the character under
        " the cursor
        let l:selection_lines[-1] = l:selection_lines[-1][: l:offset2
                    \ - (&selection == 'inclusive' ? 1 : 2) - 1]
        " add the last character to the last line
        let l:selection_lines[-1] .= l:last_character
    endif

    " if we were to only do the slicing we'd get only the first byte of the
    " last character and this breaks for encodings with multibyte characters

    let l:selection_lines[0] = l:selection_lines[0][l:offset1 - 1:]
    let l:selection_text = join(l:selection_lines, "\n")
    return l:selection_text
endfunction

function! <SID>ensure_variables()
    if !exists('g:interestingwords_patterns')
        let g:interestingwords_patterns = {}
    endif
    if !exists('w:interestingwords_matches')
        let w:interestingwords_matches = {}
    endif
endfunction

function! <SID>reapply_in_current_window()
    if exists('w:interestingwords_applied_highlights')
        return
    endif
    let w:interestingwords_applied_highlights = 1
    call <SID>ensure_variables()
    for [l:word_num, l:pattern] in items(g:interestingwords_patterns)
        if !has_key(w:interestingwords_matches, l:word_num)
            call <SID>add_match(l:word_num, l:pattern)
        endif
    endfor
endfunction

" functions pertaining to colors {{{

function! <SID>healthy_hl(highlight_name)
    if !hlexists(a:highlight_name)
        return 0
    endif
    redir => l:highlight_status
        exec "silent highlight " . a:highlight_name
    redir END
    return (l:highlight_status !~ "cleared")
endfunction

function! <SID>ensure_highlights()
    if !<SID>healthy_hl("InterestingWords0")
        highlight! clear InterestingWords0
        highlight!       InterestingWords0              ctermfg=217  ctermbg=232 cterm=bold,reverse        guifg=#D99595    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords1")
        highlight! clear InterestingWords1
        highlight!       InterestingWords1              ctermfg=155  ctermbg=232 cterm=bold,reverse        guifg=#95D951    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords2")
        highlight! clear InterestingWords2
        highlight!       InterestingWords2              ctermfg=227  ctermbg=232 cterm=bold,reverse        guifg=#D9D951    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords3")
        highlight! clear InterestingWords3
        highlight!       InterestingWords3              ctermfg=045  ctermbg=232 cterm=bold,reverse        guifg=#00B7D9    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords4")
        highlight! clear InterestingWords4
        highlight!       InterestingWords4              ctermfg=183  ctermbg=232 cterm=bold,reverse        guifg=#B795D9    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords5")
        highlight! clear InterestingWords5
        highlight!       InterestingWords5              ctermfg=086  ctermbg=232 cterm=bold,reverse        guifg=#51D9B7    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords6")
        highlight! clear InterestingWords6
        highlight!       InterestingWords6              ctermfg=203  ctermbg=232 cterm=bold,reverse        guifg=#D95151    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords7")
        highlight! clear InterestingWords7
        highlight!       InterestingWords7              ctermfg=040  ctermbg=232 cterm=bold,reverse        guifg=#00B700    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords8")
        highlight! clear InterestingWords8
        highlight!       InterestingWords8              ctermfg=214  ctermbg=232 cterm=bold,reverse        guifg=#D99500    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords9")
        highlight! clear InterestingWords9
        highlight!       InterestingWords9              ctermfg=033  ctermbg=232 cterm=bold,reverse        guifg=#0073D9    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords10")
        highlight! clear InterestingWords10
        highlight!       InterestingWords10             ctermfg=171  ctermbg=232 cterm=bold,reverse        guifg=#B751D9    guibg=#080808    gui=bold,reverse
    endif
    if !<SID>healthy_hl("InterestingWords11")
        highlight! clear InterestingWords11
        highlight!       InterestingWords11             ctermfg=043  ctermbg=232 cterm=bold,reverse        guifg=#00B795    guibg=#080808    gui=bold,reverse
    endif
endfunction

" }}}
" Functions pertaining to matches {{{

function! <SID>add_match(word_num, pattern)
    call <SID>ensure_variables()
    let l:match = matchadd('InterestingWords' . a:word_num, a:pattern, -1)
    let w:interestingwords_matches[a:word_num] = l:match
    let g:interestingwords_patterns[a:word_num] = a:pattern
endfunction

function! <SID>del_match(word_num)
    call <SID>ensure_variables()
    try
        call matchdelete(w:interestingwords_matches[a:word_num])
    catch /E716:/
    catch /E803:/
    endtry
    try
        call remove(w:interestingwords_matches, a:word_num)
    catch /E716:/
    catch /E803:/
    endtry
    try
        call remove(g:interestingwords_patterns, a:word_num)
    catch /E716:/
    catch /E803:/
    endtry
endfunction

" }}}
" }}}
" public/exposed functions {{{

function! interestingwords#toggle_syntax()
    call VimRC_ToggleSyntax()
    if &syntax != ''
        call <SID>ensure_highlights()
    endif
endfunction

function! interestingwords#reset_all()
    let l:current_window = winnr()
    try
        call <SID>ensure_variables()
        let l:old_patterns = g:interestingwords_patterns
        for [l:word_num, l:pattern] in items(l:old_patterns)
            windo call <SID>del_match(l:word_num)
        endfor
    finally
        silent execute l:current_window . 'wincmd w'
    endtry
endfunction

function! interestingwords#highlight_word(word_num)
    call <SID>ensure_highlights()
    let l:current_window = winnr()
    try
        windo call <SID>del_match(a:word_num)
    finally
        silent execute l:current_window . 'wincmd w'
    endtry
    let l:word = expand('<cword>')
    let l:pattern = '\V\<' . escape(l:word, '\') . '\>'
    try
        windo call <SID>add_match(a:word_num, l:pattern)
    finally
        silent execute l:current_window . 'wincmd w'
    endtry
endfunction

function! interestingwords#highlight_selection(word_num)
    call <SID>ensure_highlights()
    let l:current_window = winnr()
    try
        windo call <SID>del_match(a:word_num)
    finally
        silent execute l:current_window . 'wincmd w'
    endtry
    let l:selected_text = <SID>get_selection()
    let l:escaped_text = substitute(escape(l:selected_text, '\'), "\n", '\\n', 'g')
    let l:pattern = '\V' . l:escaped_text . ''
    try
        windo call <SID>add_match(a:word_num, l:pattern)
    finally
        silent execute l:current_window . 'wincmd w'
    endtry
    normal! gvv
endfunction

" }}}
" mappings {{{

nnoremap <silent> <Plug>(interestingwords#resetwords)
            \ :call interestingwords#reset_all()<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-0)
            \ :call interestingwords#highlight_word(0)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-1)
            \ :call interestingwords#highlight_word(1)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-2)
            \ :call interestingwords#highlight_word(2)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-3)
            \ :call interestingwords#highlight_word(3)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-4)
            \ :call interestingwords#highlight_word(4)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-5)
            \ :call interestingwords#highlight_word(5)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-6)
            \ :call interestingwords#highlight_word(6)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-7)
            \ :call interestingwords#highlight_word(7)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-8)
            \ :call interestingwords#highlight_word(8)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-9)
            \ :call interestingwords#highlight_word(9)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-10)
            \ :call interestingwords#highlight_word(10)<CR>
nnoremap <silent> <Plug>(interestingwords#highlight-cword-11)
            \ :call interestingwords#highlight_word(11)<CR>
xnoremap <silent> <Plug>(interestingwords#resetwords)
            \ :call interestingwords#reset_all()<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-0)
            \ :call interestingwords#highlight_selection(0)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-1)
            \ :call interestingwords#highlight_selection(1)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-2)
            \ :call interestingwords#highlight_selection(2)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-3)
            \ :call interestingwords#highlight_selection(3)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-4)
            \ :call interestingwords#highlight_selection(4)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-5)
            \ :call interestingwords#highlight_selection(5)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-6)
            \ :call interestingwords#highlight_selection(6)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-7)
            \ :call interestingwords#highlight_selection(7)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-8)
            \ :call interestingwords#highlight_selection(8)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-9)
            \ :call interestingwords#highlight_selection(9)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-10)
            \ :call interestingwords#highlight_selection(10)<CR>
xnoremap <silent> <Plug>(interestingwords#highlight-sel-11)
            \ :call interestingwords#highlight_selection(11)<CR>

" }}}
" create autocommands {{{

augroup interestingwords
    autocmd!
    autocmd WinEnter * call <SID>reapply_in_current_window()
augroup END

" }}}

" vim: foldmethod=marker foldenable
