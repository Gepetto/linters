# Linters for C+++ & Python

## Build

```
docker build -t gepetto/linters .
```

## Push

```
docker push gepetto/linters
```

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
