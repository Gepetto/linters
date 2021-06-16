#!/bin/bash -eux

check-clang-format.sh
chown -R $(stat -c "%u:%g" .) .
flake8 .
yapf -ri .
exit $(git diff --ignore-submodules | wc -l)
