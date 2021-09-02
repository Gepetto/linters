#!/bin/bash

clang-format-6.0 -i $(find . -path ./cmake -prune -o -iregex '.*\.\(h\|c\|hh\|cc\|hpp\|cpp\|hxx\|cxx\)$' -print)
chown -R "$(stat -c "%u:%g" .)" .
git diff --ignore-submodules
exit "$(git diff --ignore-submodules | wc -l)"
