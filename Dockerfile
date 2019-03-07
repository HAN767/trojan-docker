FROM alpine:3.9

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
        git \
    && git clone https://github.com/trojan-gfw/trojan.git \
    && cd trojan \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr . \
    && make install \
    && strip -s /usr/bin/trojan \
    && cd .. \
    && rm -rf trojan \
    && apk del .build-deps \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

EXPOSE 443

CMD ["trojan"]
