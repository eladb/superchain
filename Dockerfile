FROM alpine:3.9

# ------------------------------------------------------------------------------------------------------------------
# nodejs 10.16.0
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.10/main nodejs=10.16.0-r0 npm=10.16.0-r0

# ------------------------------------------------------------------------------------------------------------------
# python 3.6.8 (https://github.com/frol/docker-alpine-python3/blob/master/Dockerfile)
RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

# ------------------------------------------------------------------------------------------------------------------
# java8
RUN apk add --no-cache openjdk8 maven

# ------------------------------------------------------------------------------------------------------------------
# .net core 2.2 (https://github.com/dotnet/dotnet-docker/blob/master/2.2/runtime/alpine3.9/amd64/Dockerfile)
ENV DOTNET_VERSION 2.2.5
RUN wget -O dotnet.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-musl-x64.tar.gz \
    && dotnet_sha512='f4cab0135f69f3819a905640e59718f292fecef849480da16043e6cbbff72d80edbc64fbc3bf84bf6151148d9982dec67038020deba1e9ca4a1c61a35bcaea56' \
    && echo "$dotnet_sha512  dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -C /usr/share/dotnet -xzf dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && rm dotnet.tar.gz

# ruby 2.5.5
RUN apk add ruby=2.5.5-r0

# bash
RUN apk add bash