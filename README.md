# Linters for C+++ & Python

## Use locally

:warning: this will update your current working directory :warning:

```
docker run --rm -v $PWD:/app -w /app -it gepetto/linters
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
