#!/bin/bash -eux

check-clang-format.sh || true
flake8 .
yapf -ri .
exit "$(git diff --ignore-submodules | wc -l)"
