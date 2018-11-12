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

if command -v less >/dev/null 2>&1; then
    typeset -gx PAGER="$(command -v less)"
    typeset -gx LESS='-imx4RFsXS'
    typeset -gx LESSHISTFILE="/dev/null"

    # Documented in `man 5 termcap` (two leter suffixes).
    #
    # The existence of LESS_TERMCAP_?? is not well documented, yet there's an
    # inexhaustive reference at:
    #   - https://unix.stackexchange.com/a/108840

    typeset -gx LESS_TERMCAP_mb=$'\033[1;31m'   # blink-start     -> bold-red
    typeset -gx LESS_TERMCAP_md=$'\033[1;34m'   # bold-start      -> bold-blue
    typeset -gx LESS_TERMCAP_me=$'\033[0m'      # end all modes   -> reset-all
    typeset -gx LESS_TERMCAP_se=$'\033[0m'      # end standout    -> reset-all
    typeset -gx LESS_TERMCAP_so=$'\033[1;37m'   # start standout  -> bold-white
    typeset -gx LESS_TERMCAP_ue=$'\033[0m'      # end underline   -> reset-all
    typeset -gx LESS_TERMCAP_us=$'\033[1;4;35m' # start underline ->
                                                #       bold underline magenta

    # Documented in `man 1 lesskey`
    typeset -gx LESSKEY=''
    if [[ -e "${HOME}/.local" ]]; then
        LESSKEY="${HOME}/.local/dot_less"
    else
        LESSKEY="${HOME}/.less"
    fi

elif command -v more >/dev/null 2>&1; then
    typeset -gx PAGER="$(command -v more)"
else
    unset PAGER
fi

if [[ -n "${PAGER:-}" ]]; then
    typeset -gx MANPAGER="${PAGER}"
else
    unset MANPAGER
fi

if command -v vim >/dev/null 2>&1; then
    typeset -gx EDITOR="$(command -v vim)"
elif command -v emacs >/dev/null 2>&1; then
    typeset -gx EDITOR="$(command -v emacs) -nw"
else
    unset  EDITOR
fi

if [[ -n "${EDITOR:-}" ]]; then
    typeset -gx VISUAL="${EDITOR}"
else
    unset VISUAL
fi

typeset DOT_LESSKEY="${HOME}/.local/dot_lesskey"
if command -v lesskey >/dev/null 2>&1 && \
   [[ -e "${DOT_LESSKEY}" ]]; then
    if [[ ! -e "${LESSKEY:-}" ]] || \
       [[ "${LESSKEY:-}" -ot "${DOT_LESSKEY}" ]]; then
        command lesskey "${DOT_LESSKEY}"
    fi
fi
unset DOT_LESSKEY
