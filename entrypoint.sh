#!/bin/bash -eux

CPP=true
PYTHON=true
CLANG_ARGS=""
BLACK=$(grep -q psf/black README.md 2> /dev/null && echo true || echo false)
RUFF=$(grep -q ruff README.md 2> /dev/null && echo true || echo false)

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
        --clang-args)
            shift
            CLANG_ARGS="$1"
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
        --ruff)
            RUFF=true
            shift
            ;;
        --flake8)
            RUFF=false
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
    find . -path ./cmake -prune -o -iregex '.*\.\(h\|c\|hh\|cc\|hpp\|cpp\|hxx\|cxx\)$' \
        -exec clang-format "$CLANG_ARGS" --style=Google -i {} +
fi

if $PYTHON
then
    if $RUFF
    then
        ruff .
    else
        flake8 .
    fi
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
