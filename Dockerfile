FROM alpine:3.10

# nodejs
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.10/main nodejs=10.16.0-r0 npm=10.16.0-r0

# https://github.com/frol/docker-alpine-python3/blob/master/Dockerfile
RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

# java8
RUN apk add --no-cache openjdk8 maven
