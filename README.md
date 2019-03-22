# Linters for C+++ & Python

## Build

```
docker build -t eur0c.laas.fr:5000/gepetto/buildfarm/format .
```

## Push

```
docker push eur0c.laas.fr:5000/gepetto/buildfarm/format
```

## Use locally

:warning: this will update your current working directory :warning:

```
docker run --rm -v $PWD:/app -w /app -it eur0c.laas.fr:5000/gepetto/buildfarm/format
```

## Use in Gitlab CI

```
format:
  image: eur0c.laas.fr:5000/gepetto/buildfarm/format
  script:
    - isort -c
    - flake8 .
    - check-clang-format.sh
```
