#!/bin/bash -eux

CPP=true
PYTHON=true
CLANG=clang-format-12
BLACK=$(grep -q psf/black README.md 2> /dev/null && echo true || echo false)

while [[ $# -gt 0 ]]
do
    case $1 in
        --no-cpp)
            CPP=false
            shift
            ;;
        --no-python)
            PYTHON=false
            shift
            ;;
        --clang-6)
            CLANG=clang-format-6.0
            cp /root/.clang-format{-6.0,}
            shift
            ;;
        --black)
            BLACK=true
            shift
            ;;
        --yapf)
            BLACK=false
            shift
            ;;
        *)
            echo "incorrect argument: $1" >&2
            echo "remaining arguments are: $*" >&2
            exit 1
            ;;
    esac
done

if $CPP
then
    find . -path ./cmake -prune -o -iregex '.*\.\(h\|c\|hh\|cc\|hpp\|cpp\|hxx\|cxx\)$' -exec $CLANG -i {} +
fi

if $PYTHON
then
    flake8 .
    if $BLACK
    then
        black .
    else
        yapf -ri .
    fi
fi

chown -R "$(stat -c "%u:%g" .)" .
git diff --ignore-submodules
exit "$(git diff --ignore-submodules | wc -l)"
