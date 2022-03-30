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
- `--clang-6`: if you want clang-format-6.0 instead of the default clang-format-12
- `--clang-default`: use latest clang-format from PyPI with `--style=Google` without `.clang-format` files
- `--black`: if you want to use black instead of yapf, and you don't have a README.md including the "psf/black" string
- `--yapf`: if you want to use yapf instead of black, even if you have a README.md including a "psf/black" string

### Manually

You should first setup the configurations files from this repository by putting the `setup.cfg` and the `.clang-format`
files in a parent directory of your project.

Then you can go to your project, and try the following commands:

```
yapf -ri .
flake8 .  # or "black ." depending on the project
find . -path ./cmake -prune -o -iregex '.*\.\(h\|c\|hh\|cc\|hpp\|cpp\|hxx\|cxx\)$' -exec clang-format-12 -i {} +
```

## Use in Gitlab CI

```
format:
  image:
    name: gepetto/linters
    entrypoint: [""]
  before_script:
    - test -f /builds/setup.cfg || ln -s /root/setup.cfg /builds
    - test -f /builds/.clang-format || ln -s /root/.clang-format /builds
  script:
    - entrypoint.sh
```
