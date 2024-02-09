FROM ubuntu:22.04

WORKDIR /root/src

RUN --mount=type=cache,sharing=locked,target=/root/.cache \
    --mount=type=cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,sharing=locked,target=/var/lib/apt \
    apt-get update -qqy && apt-get install -qqy \
    git \
    python-is-python3 \
    python3-pip \
 && python -m pip install --upgrade pip\
 && python -m pip install \
    clang-format \
    black \
    flake8 \
    isort \
    nbqa \
    ruff \
    yapf[pyproject] \
 && mkdir -p /root/.config/yapf

ADD entrypoint.sh /usr/local/bin/
ADD setup.cfg /root/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
