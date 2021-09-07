#!/bin/bash

# shellcheck disable=SC2046
clang-format-12 -i $(find . -path ./cmake -prune -o -iregex '.*\.\(h\|c\|hh\|cc\|hpp\|cpp\|hxx\|cxx\)$' -print)
chown -R "$(stat -c "%u:%g" .)" .
git diff --ignore-submodules
exit "$(git diff --ignore-submodules | wc -l)"
