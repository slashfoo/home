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

alias gr='\grep -i --color=auto'
alias grep='\grep --color=auto'

alias reload='\env reset; \builtin rehash; \builtin source ${HOME}/.zshenv'
alias rh='\builtin rehash'

alias cpr='\rsync -havz --partial --info=progress2'
alias mvr='\rsync -havz --partial --info=progress2 --remove-source-files'

alias abspath='\realpath -s'

alias nl='\nl -ba'

alias ffprobe='\ffprobe -hide_banner'
alias ffmpeg='\ffmpeg -hide_banner'
alias http='\http --verbose --style=native'
