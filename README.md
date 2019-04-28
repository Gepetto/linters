# Linters for C++ & Python

## Build

```
docker build -t gepetto/linters .
```

## Push

```
docker push gepetto/linters
```

## Use locally

### With the pre-built docker image

:warning: this will update your current working directory :warning:

```
docker run --rm -v $PWD:/root/src -it gepetto/linters
```

### Manually

You should first setup the configurations files from this repository, with

```
./setup_configuration.sh
```

Then you can go to your project, and try the following commands:

```
yapf -ri .
flake8 .
clang-format-6.0 -i $(find . -path ./cmake -prune -o -iregex '.*\.\(h\|c\|hh\|cc\|hpp\|cpp\|hxx\|cxx\)$' -print)
```

## Use in Gitlab CI

```
format:
  image: gepetto/linters
  script:
    - isort -c
    - flake8 .
    - check-clang-format.sh
```
