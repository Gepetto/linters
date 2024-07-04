FROM ubuntu:24.04

WORKDIR /root/src

RUN --mount=type=cache,sharing=locked,target=/root/.cache \
    --mount=type=cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,sharing=locked,target=/var/lib/apt \
    apt-get update -qqy && apt-get install -qqy \
    git \
    pipx \
 && pipx install \
    clang-format \
    nbqa \
    ruff

ADD entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

ENV PATH=/root/.local/bin:$PATH
