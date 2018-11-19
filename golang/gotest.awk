# vim: commentstring=#\ %s
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

/(^--- )?FAIL:?/ {
    printf "\x1b[38;5;9m%s\x1b[0m\n", $0
    next
}
/(^--- )?PASS:?/ || /^ok\s+/ {
    printf "\x1b[38;5;10m%s\x1b[0m\n", $0
    next
}

/RUN/ || /^(goos|goarch):\s+/ {
    printf "\x1b[38;5;244m%s\x1b[0m\n", $0
    next
}

/^\s+Error:/ { in_error=1 }
/^\s+Test:/ { in_error=0 }

in_error && /^\s+-/ {
    printf "\x1b[38;5;1m%s\x1b[0m\n", $0
    next
}

in_error && /^\s+\+/ {
    printf "\x1b[38;5;2m%s\x1b[0m\n", $0
    next
}

/^(\?\s+|(got|want):$)/ || in_error {
    printf "\x1b[38;5;13m%s\x1b[0m\n", $0
    next
}

/^coverage:/ || /^\s+Error Trace:/ {
    printf "\x1b[38;5;255m%s\x1b[0m\n", $0
    next
}

{
    print;
}
