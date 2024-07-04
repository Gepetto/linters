#!/bin/bash -eux

CPP=true
PYTHON=true
CLANG_ARGS="--style=Google"

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
            if [[ "$1" = "--no-sort-includes" ]]
            then
                CLANG_ARGS='--style={BasedOnStyle: Google, SortIncludes: false}'
            else
                CLANG_ARGS="$1"
            fi
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
        -exec clang-format "$CLANG_ARGS" -i {} +
fi

if $PYTHON
then
    ruff check --exit-non-zero-on-fix
    ruff format --check
fi

chown -R "$(stat -c "%u:%g" .)" .
git diff --ignore-submodules
exit "$(git diff --ignore-submodules | wc -l)"
