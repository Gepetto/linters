# Linters for C++ & Python

## Use locally

### With the pre-built docker image

:warning: this will update your current working directory :warning:

```
docker run --rm -v $PWD:/root/src -it gepetto/linters
```

Available flags:

- `--no-cpp`: if you don't want to lint c++ code
- `--no-python`: if you don't want to lint python code
- `--clang-args`: if you want to provide your own clang-format flags

### Manually

You can go to your project, and try the following commands:

```
ruff check
ruff format
find . -path ./cmake -prune -o -iregex '.*\.\(h\|c\|hh\|cc\|hpp\|cpp\|hxx\|cxx\)$' -exec clang-format -i {} +
```

## Use in Gitlab CI

```
format:
  image:
    name: gepetto/linters
    entrypoint: [""]
  script:
    - entrypoint.sh
```
