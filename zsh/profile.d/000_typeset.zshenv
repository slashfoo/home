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

# parameters set or used by zsh, here they're merely set to auto-export
# Documented in `man 1 zshparam`
typeset -gx USER LOGNAME HOST
typeset -gx COLUMNS LINES
typeset -gx UID GID
typeset -gx EUID EGID

# in addition to auto-export, set these to be unique
#
# These are also documented in `man 1 zshparam` but have the particularity
# that the lower-case are arrays, and the upper-cased are strings with the
# elements of such array joined by ':' (colon). The values are bound and
# updated automatically in a bi-directional fashion.
typeset -gxU CDPATH cdpath
typeset -gxU FIGNORE fignore
typeset -gxU FPATH fpath
typeset -gxU MAILPATH mailpath
typeset -gxU MANPATH manpath
typeset -gxU MODULE_PATH module_path
typeset -gxU PATH path
typeset -gxU WATCH watch

# these are not automatically provided, and are set here to emulate the same
# behavior as above for automatically updating a string of joined values from
# an array automatically, the last parameter ':' (colon) or ' ' (space) is the
# separator. For more information see typeset in `man 1 zshbuiltins`
typeset -gxTU LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-}" ld_library_path ':'
typeset -gxTU PKG_CONFIG_PATH="${PKG_CONFIG_PATH:-}" pkg_config_path ':'
typeset -gxTU LDFLAGS="${LDFLAGS:-}" ldflags ' '
typeset -gxTU CFLAGS="${CFLAGS:-}" cflags ' '
typeset -gxTU CPPFLAGS="${CPPFLAGS:-}" cppflags ' '

# suffixes to be ignored by filename completion
# Documented in `man 1 zshparam`
fignore+=(
    .DS_Store
    .beam
    .class
    .dll
    .gem
    .git
    .gz
    .hg
    .luac
    .o
    .obj
    .orig
    .out
    .pyc
    .pyo
    .rbc
    .rbo
    .so
    .spl
    .svn
    .swp
    .zwc
    \~
)

typeset -gx LANG='en_US.UTF-8'
typeset -gx LANGUAGE='en_US:en'

# TIME_STYLE documented in `info '(coreutils) Formatting file timestamps'`
typeset -gx TIME_STYLE="+%Y-%m-%dT%H:%M:%S%:z"

# Since %:z is not supported by the `tree` command, this is defined for use in
# aliases
typeset -gx TREE_TIMEFMT="%Y-%m-%dT%H:%M:%S%z"

# LC_COLLATE=C makes sorting in some utilities (e.g. sort, ls, and tree) behave
# more in line with what I expect upper case leters are sorted before lower
# case, and symbols are taken into account when sorting so files that start
# with dot will all be sorted before other files. By default with
# LANG=en_US.UTF-8 you'd get a list similar to the following, as properly
# sorted.
#
# Behavior is explained in `info '(coreutils)' sort invocation`
#
# - clipper
# - colordiff
# - .cscope.out
# - .cscope.out.in
# - .cscope.out.po
# - ddvorak
#
# With LC_COLLATE=C that same list would be sorted as:
#
# - .cscope.out
# - .cscope.out.in
# - .cscope.out.po
# - clipper
# - colordiff
# - ddvorak
typeset -gx LC_COLLATE=C

# Set the default block size for df, du and ls.
# Documented in `info '(coreutils) Block size'`
typeset -gx BLOCK_SIZE="1MiB"
