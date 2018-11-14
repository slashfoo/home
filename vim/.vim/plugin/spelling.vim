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

if exists('g:loaded_spelling')
    finish
endif
if $MYVIMDIR == ""
    finish
endif
let g:loaded_spelling = 1

if !exists('g:extra_wordlists')
    let g:extra_wordlists = [
    \   "/usr/share/dict/words",
    \   "/usr/share/dict/american-english-huge",
    \   "/usr/share/dict/american-english",
    \ ]
endif
if !exists('g:extra_thesauri')
    let g:extra_thesauri = [
    \   $MYVIMDIR . "/spell/mthesaur.txt",
    \ ]
endif
if !exists('g:default_spellfiles')
    let g:default_spellfiles = [
    \   $MYVIMDIR . "/spell/custom-dictionary.utf-8.add",
    \   $MYVIMDIR . "/spell/local-dictionary.utf-8.add",
    \ ]
endif

for s:spellfile in g:default_spellfiles
    if !filereadable(s:spellfile)
        silent execute "!install -m 0600 /dev/null " . shellescape(s:spellfile)
    endif
endfor

for s:wordlist in g:extra_wordlists
    if filereadable(s:wordlist)
        execute "set dictionary+=" . s:wordlist
    elseif  filereadable(s:wordlist . ".tar.xz")
        echom "Extracting " . s:wordlist . " from " . s:wordlist . ".tar.xz"
        execute "!tar -Jx -C " . shellescape($MYVIMDIR . "/spell")
                    \ . " -f " . shellescape(s:wordlist . ".tar.xz")
                    \ . " " . shellescape(fnamemodify(s:wordlist, ":t"))
        if filereadable(s:wordlist)
            echom "Successfully extracted "
                        \ . s:wordlist . " adding to dictionaries"
            execute "set dictionary+=" . s:wordlist
        endif
    endif
endfor

for s:thesaurus in g:extra_thesauri

    " File to be used with the plugin ron89/thesaurus_query.vim
    "
    " I used to have the following line
    "   execute "set thesaurus+=" . s:thesaurus
    "
    " This proved problematic due to the unexpected (to vim) thesaurus format,
    " if I can find a plain file I can use with the internal vim thesaurus
    " option, that'd be great, until then, I'll be using thesaurus_query

    if !filereadable(s:thesaurus) && filereadable(s:thesaurus . ".tar.xz")
        echom "Extracting " . s:thesaurus . " from " . s:thesaurus . ".tar.xz"
        execute "!tar -Jx -C " . shellescape($MYVIMDIR . "/spell")
            \ . " -f " . shellescape(s:thesaurus . ".tar.xz") . " "
            \ . shellescape(fnamemodify(s:thesaurus, ":t"))
        if filereadable(s:thesaurus)
            echom "Successfully extracted " . s:thesaurus
        endif
    endif
endfor

function! spelling#set_lang(lang)
    set spellfile=
    execute "setlocal spell spelllang=" . a:lang
    if exists("g:default_spellfiles")
        for l:spellfile in g:default_spellfiles
            execute "set spellfile+=" . l:spellfile
        endfor
    endif
    for l:lang in split(a:lang, ",")
        let l:spellfile = $HOME . "/.vim/spell/" . l:lang . ".utf-8.add"
        if filereadable(l:spellfile)
            execute "set spellfile+=" . l:spellfile
        endif
    endfor
endfunction

augroup spelling_set
    autocmd!

    autocmd VimEnter *
            \  call spelling#set_lang('en')
            \| set nospell

augroup end

command! -nargs=1 LL call spelling#set_lang("<args>")
