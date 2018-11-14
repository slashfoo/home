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

" Note taking commands, inspired by Conner McDaniel's setup from 2011 exposed
" on his post: http://connermcd.com/blog/2011/10/21/notetaking-with-vim.html
" and his youtube video: https://www.youtube.com/watch?v=HJ93UYeaoww

if exists('g:loaded_notes')
  finish
endif
let g:loaded_notes = 1

" Define defaults and potentially create the directories {{{

if !exists('g:notes_directory')
    let g:notes_directory = $HOME . "/Notes"
endif
if !exists('g:notes_extension')
    let g:notes_extension = 'md'
endif

for s:notes_dir in [g:notes_directory]
    if !isdirectory(s:notes_dir)
        echom "Creating Notes directory at: " . s:notes_dir
        call mkdir(s:notes_dir, "p", 0700)
        if isdirectory(s:notes_dir)
            echom "Successfully created: " . s:notes_dir
        endif
    endif
endfor

" }}}
" public/exposed functions {{{

function! notes#get_file(directory, extension, words_string, bang)
    let l:note_directory = a:directory =~ '/$'
                \ ? a:directory
                \ : a:directory . '/'
    let l:note_extension = a:extension =~ '^\.'
                \ ? a:extension
                \ : '.' . a:extension
    let l:note_name = join(split(a:words_string, '\v( |_|-)'), '_')

    let l:path = l:note_directory
                \ . fnameescape(
                \     ((a:bang)?strftime('%Y%m%dT%H%M%S_'):'')
                \   . l:note_name
                \   . l:note_extension
                \   )

    return l:path
endfunction

function! notes#notes_list_cmd(directory)
    let l:note_directory = a:directory =~ '/$'
                \ ? a:directory : a:directory . '/'
    if exists(':Files')
        let l:cmd = ':Files ' . fnameescape(l:note_directory)
    else
        let l:cmd = ':edit ' . fnameescape(l:note_directory)
    endif
    return l:cmd
endfunction

function! notes#grep(directory, extension, pattern) abort
    let l:note_directory = a:directory =~ '/$'
                \ ? a:directory
                \ : a:directory . '/'
    let l:note_extension = a:extension =~ '^\.'
                \ ? a:extension
                \ : '.' . a:extension
    let l:notes_glob = l:note_directory . '**/*' . l:note_extension

    let l:pattern = '/\v' . a:pattern . '/'

    try
        execute 'vimgrep ' . l:pattern . ' ' . l:notes_glob
    catch /E480: No match/
    endtry
    execute 'cwindow'
endfunction

" }}}
" commands {{{

command! -nargs=1 -bang Note
            \ execute "edit " .
            \ notes#get_file(g:notes_directory, g:notes_extension,
            \                "<args>", <bang>0)
command! -nargs=0 Notes execute notes#notes_list_cmd(g:notes_directory)
command! -nargs=1 Ngrep call notes#grep(g:notes_directory,
            \ g:notes_extension, "<args>")

" }}}
" vim: foldmethod=marker foldenable
