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

# compose the format to be used for the output of the zsh `time` builtin
typeset -a TIMEFMT_ELEMS=(
  ""
  "Command being timed:  “ %J ”"
  "User time: %mU"
  "System time: %mS"
  "Percent of CPU this job got: %P"
  "Elapsed (wall clock) time: %*E"
)
typeset -g TIMEFMT="${(F)TIMEFMT_ELEMS}"
unset TIMEFMT_ELEMS

# set zsh to display the timing information of the previously executed command
# in a shell, if it takes longer than 1 second to execute.
#
# "Command being timed" is incorrectly displayed for pipes and functions,
# regardless, this automatic timing is generally useful.
typeset -gi REPORTTIME=1
