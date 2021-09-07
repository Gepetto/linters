# Linters for C++ & Python

## Use locally

### With the pre-built docker image

:warning: this will update your current working directory :warning:

```
docker run --rm -v $PWD:/root/src -it gepetto/linters
```

### Manually

You should first setup the configurations files from this repository by putting the `setup.cfg` and the `.clang-format`
files in a parent directory of your project.

Then you can go to your project, and try the following commands:

```
yapf -ri .
flake8 .  # or "black ." depending on the project
clang-format-12 -i $(find . -path ./cmake -prune -o -iregex '.*\.\(h\|c\|hh\|cc\|hpp\|cpp\|hxx\|cxx\)$' -print)
```

## Use in Gitlab CI

```
format:
  image: gepetto/linters
  before_script:
    - test -f /builds/setup.cfg || ln -s /root/setup.cfg /builds
    - test -f /builds/.clang-format || ln -s /root/.clang-format /builds
  script:
    - entrypoint.sh
```

(if your project doesn't have any python code, add `--no-python` to `entrypoint.sh`)
