FROM docker.io/debian:11 AS builder

RUN apt update -y && apt upgrade -y && \
    apt install -y \
        build-essential \
        git \
        wget \
        && \
    git clone https://github.com/richfelker/musl-cross-make /musl-cross-make

COPY config.mak /musl-cross-make/config.mak

RUN cd /musl-cross-make && \
    make && \
    make install

FROM docker.io/debian:11

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y build-essential

COPY --from=builder /musl-cross-make/output /usr/local
