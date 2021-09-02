#!/bin/bash -eux

check-clang-format.sh || true
flake8 .
if grep -q psf/black README.md
then
    black .
else
    yapf -ri .
fi
exit "$(git diff --ignore-submodules | wc -l)"
