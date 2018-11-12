# Copyright 2018 Jamiel Almeida
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# characters considered to be part of a word for zle (zsh line editor)
typeset -gx WORDCHARS='*?_-.[]~&;!#$%^(){}|'

# this is the function used to generate the zkbd files mentioned below
autoload -Uz zkbd

typeset ZKBD_DIR="${${(%):-%x}:A:h:h}/zkbd"

# expected default file to load with terminal key code definitions
typeset ZKBD_FILE="${ZKBD_DIR}/${TERM}-${${DISPLAY:t}:-${VENDOR}-${OSTYPE}}"
if [[ "$(uname -v)" == *"Microsoft"* ]]; then
    # override file to load if running on the Windows Subsystem for Linux
    ZKBD_FILE="${ZKBD_DIR}/${TERM}-WSL"
fi

if [[ -e "${ZKBD_FILE}" ]]; then
    source "${ZKBD_FILE}"
fi

unset ZKBD_DIR
unset ZKBD_FILE

# default the zsh mappings to be the emacs-y ones
bindkey -e

# accept-and-hold runs the command but keeps it in the line editor buffer
bindkey '^j' accept-and-hold

# copies the last word, conevient for renames for example
bindkey '^o' copy-prev-shell-word

# Based on the file: plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
# that is part of: https://github.com/robbyrussell/oh-my-zsh
#
# It's attributed to (broken link) on that repository
# http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
#
# As such, this function `fancy-ctrl-z` retains copyright notice and
# license defined in the source repository. The text was taken verbatim and
# re-formatted to fit into 80 columns. Added myself to the copyright notice
# above the one it had.
fancy-ctrl-z () {
    # Copyright 2018 Jamiel Almeida
    # Copyright (c) 2009-2018 Robby Russell and contributors
    #
    # See the full list at
    # https://github.com/robbyrussell/oh-my-zsh/contributors
    #
    # Permission is hereby granted, free of charge, to any person obtaining a
    # copy of this software and associated documentation files (the
    # "Software"), to deal in the Software without restriction, including
    # without limitation the rights to use, copy, modify, merge, publish,
    # distribute, sublicense, and/or sell copies of the Software, and to permit
    # persons to whom the Software is furnished to do so, subject to the
    # following conditions:
    #
    # The above copyright notice and this permission notice shall be included
    # in all copies or substantial portions of the Software.
    #
    # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    # OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    # MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
    # NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
    # DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
    # OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
    # USE OR OTHER DEALINGS IN THE SOFTWARE.

    local NUM_JOBS="${(%):-%j}"
    if [[ "${NUM_JOBS}" -gt 0 ]] && [[ $#BUFFER -eq 0 ]]; then
        # background jobs present and empty buffer, runs `fg`
        BUFFER="fg"
        zle accept-line
    elif [[ $#BUFFER -ne 0 ]]; then
        # non-empty buffer
        # push-input sends text in buffer to the buffer stack and clears the
        # buffer
        zle push-input
    else
        zle clear-screen
    fi
}
zle -N fancy-ctrl-z
bindkey '^z' fancy-ctrl-z

insert-newline () {
    BUFFER="${BUFFER}"$'\n'
    CURSOR=$(( CURSOR + 1 ))
}
zle -N insert-newline

insert-tab () {
    BUFFER="${BUFFER}"$'\t'
    CURSOR=$(( CURSOR + 1 ))
}
zle -N insert-tab

# Edit the command line using your usual editor.
#
# If the editor returns with exit code 0 load the contents of the file onto the
# buffer otherwise empty the buffer and discard whatever was on the tempfile.
#
# Inspired by the functionality provided by function edit-command-line in
# zshcontrib. Although behavior is different and code is disjunct, credit for
# the idea goes to the Zsh Development Group as the authors of the original
# function.
#
# Source for that function is on the file: Functions/Zle/edit-command-line
# that is part of: git://git.code.sf.net/p/zsh/code
edit-command-line () {
    local ts_format="%D{%Y%m%dT%H%M%S.%6.}"
    local tmpfile="${TMPDIR:-/tmp}/zsh-buf-$$.${(%)ts_format}"
    install -m 'u=rw,go=' /dev/null "${tmpfile}"
    print -R - "${PREBUFFER}${BUFFER}" >"${tmpfile}"

    exec </dev/tty
    ${=${VISUAL:-${EDITOR:-vi}}} "${tmpfile}"
    local RETURN_CODE="${?}"

    if [[ "${RETURN_CODE}" -eq 0 ]]; then
        print -Rz - "$(<"${tmpfile}")"
    fi

    command rm -f "${tmpfile}"
    zle send-break
    CURSOR="${#BUFFER}"

    zle redisplay
    zle reset-prompt
}
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Draw a fancy horizontal line with timestamp. Useful for presentations.
horizontal-rule () {
    local how_many="${COLUMNS:-}"
    [[ -n "${how_many}" ]] || return
    local timestamp_format="%D{%Y-%m-%dT%H:%M:%S.%3.%z}"
    local ruler_char=$'\u2501'
    local ruler_pre=""
    if [[ "${how_many}" -gt 31 ]]; then
        how_many=$(( how_many - 31 ))
        ruler_pre="${ruler_char} ${(%)timestamp_format} "
    fi

    local ruler="$(printf "${ruler_char}%.0s" {1..${how_many}})"

    local prev_cursor="${CURSOR}"
    CURSOR=0
    zle -R
    print - "\r${ruler_pre}${ruler}"

    CURSOR="${prev_cursor}"
    zle redisplay 2>/dev/null
    zle reset-prompt 2>/dev/null
}
zle -N horizontal-rule

# I set these codes to be sent by my terminal, the definitions for them are in:
#   - Xresources for URxvt
#   - ~/.config/alacritty/alacritty.yml for alacritty
#   - ~/.config/kitty/kitty.conf for kitty
#
# Some of these codes are not available on my configurations of other shells I
# use less frequently, for which a direct bind is used, or omitted

# C-Space
bindkey -s '\0' ' '
# M-Space
bindkey '<F33>' horizontal-rule
bindkey '[45~' horizontal-rule
bindkey ' ' horizontal-rule
# S-Space
bindkey -s '<F34>' ' '
bindkey -s '[46~' ' '
# C-Enter
bindkey '<F35>' accept-and-hold
bindkey '[47~' accept-and-hold
# M-Enter
bindkey '<F36>' pound-insert
bindkey '[48~' pound-insert
bindkey '' pound-insert
# S-Enter
bindkey '<F37>' insert-newline
bindkey '[49~' insert-newline
# C-Tab
bindkey '<F32>' insert-tab
bindkey '[50~' insert-tab

# Bind C-p to previous history entry, can still use Up for "up-line-or-history"
bindkey '^p' up-history
