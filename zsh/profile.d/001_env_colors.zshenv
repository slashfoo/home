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

# enable colors for tools that read CLICOLOR environment variable if our
# terminal has the word color somewhere in it's name
if [[ "${TERM:-}" == *"color"* ]]; then
    typeset -gx CLICOLOR=1
fi

# colors for when '--color' is used for grep
typeset -gxT GREP_COLORS="${GREP_COLORS:-}" grep_colors ":"
[[ -n "${GREP_COLORS:-}" ]] || \
    grep_colors=(
        'sl=0;00'  # NORMAL         = non-matching part of matching lines
        'cx=0;90'  # GRAY           = context lines
        'rv'       # needed for the above two to behave as they are commented
        'mt=1;32'  # GREEN          = matching text in greps
        'fn=0;34'  # BLUE           = file name
        'ln=0;33'  # YELLOW         = file line number
        'se=1;30'  # "BRIGHT" BLACK = field separator
    )

# colors for ls provided by gnu coreutils
# this variable is normally populated by the `dircolors` command
# For more information:
#   - check `man 5 dir_colors` or
#   - grep the output of `dircolors --print-database` on it's first letter
typeset -gxT LS_COLORS="${LS_COLORS:-}" ls_colors ":"
[[ -n "${LS_COLORS:-}" ]] || \
    ls_colors=(
      'do=00;32'           # green = door(solaris ipc construct)
      'di=00;34'           # blue = directory
      'no=00'              # default = non-filename text
      'rs=0'               # reset to normal color
      'ex=00;31'           # red = executable
      'ow=36'              # cyan = other-writable dir w/o sticky
      'or=00;38;05;232;45' # black on magenta = orphan symlink to non-existent
      'bd=00;33'           # yellow = block device
      'so=00;32'           # green = socket
      'ln=00;35'           # magenta = symlink
      'tw=00;38;05;232;46' # black on cyan = other-writable dir w/ sticky
      'sg=00;38;05;232;43' # black on yellow = file with setgid bit
      'ca=01;31'           # bright red = file with capability
      'pi=00;32'           # green = pipe
      'fi=00'              # default = filenames
      'su=00;38;05;232;41' # black on red = file with setuid bit
      'st=00;38;05;232;44' # black on blue = non-other-writable dir w/ sticky
      'cd=00;31'           # red = character dev
      'mi=00;31'           # red = missing, target of a broken link (orphan)
      'mh=01;37'           # bright white = file with more than one hard link
    )


# colors for ls on BSD systems
if [[ -z "${LSCOLORS:-}" ]]; then
    typeset -a lscolors=(
      ex # directory                                  fg=blue    bg=default
      fx # symlink                                    fg=magenta bg=default
      cx # socket                                     fg=green   bg=default
      dx # pipe                                       fg=yellow  bg=default
      bx # executable                                 fg=red     bg=default
      eg # block special                              fg=blue    bg=cyan
      ed # character special                          fg=blue    bg=yellow
      ab # setuid executable                          fg=black   bg=red
      ag # setgid executable                          fg=black   bg=cyan
      ac # dir writable by others with sticky bit set fg=black   bg=green
      ad # dir writable by others w/o sticky bit set  fg=black   bg=yellow
    )
    # LSCOLORS is documented in `man 1 ls` on BSD systems
    typeset -gx LSCOLORS="${(j::)lscolors}"
    unset lscolors
fi
