#!/bin/bash -eux

check-clang-format.sh || true
if [[ -z "${1+x}" || "$1" != "--no-python" ]]
then
    flake8 .
    if grep -q psf/black README.md
    then
        black .
    else
        yapf -ri .
    fi
fi
exit "$(git diff --ignore-submodules | wc -l)"
