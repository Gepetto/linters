FROM ubuntu:20.04

WORKDIR /root/src

RUN apt-get update -qqy && apt-get install -qqy \
    clang-format-6.0 \
    clang-format-12 \
    git \
    python-is-python3 \
    python3-pip \
 && python -m pip install --no-cache-dir \
    black \
    flake8 \
    isort \
    nbqa \
    yapf \
 && mkdir -p /root/.config/yapf \
 && rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /usr/local/bin/
ADD .clang-format .clang-format-6.0 setup.cfg /root/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
