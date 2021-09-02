FROM ubuntu:18.04

RUN apt-get update -qqy && apt-get install -qqy \
    clang-format-6.0 \
    git \
    python3-pip \
 && pip3 install --no-cache-dir \
    black \
    flake8 \
    isort \
    nbqa \
    yapf \
 && mkdir -p /root/.config/yapf \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/src
WORKDIR /root/src

ADD check-clang-format.sh entrypoint.sh /usr/local/bin/
ADD .clang-format setup.cfg /root/

CMD entrypoint.sh
