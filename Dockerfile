FROM python:2-alpine

ENV PAGES=2 \
    DIR=/opt \
    JOBS=100 \
    SITE=https://m.vk.com

ADD https://github.com/D1abloRUS/go-proxycheck/releases/download/latest/go-proxycheck /usr/local/bin/go-proxycheck
COPY docker-entrypoint.sh /usr/local/bin/

RUN apk --no-cache add --update \
      git \
      gcc \
      musl-dev \
      libxml2-dev \
      ca-certificates \
      openssl \
    && apk --no-cache add 'libxslt-dev' --update-cache --repository http://nl.alpinelinux.org/alpine/edge/main \
    && chmod +x /usr/local/bin/go-proxycheck \
    && mkdir -p /usr/include/libxml \
    && ln -s /usr/include/libxml2/libxml/xmlversion.h /usr/include/libxml/xmlversion.h \
    && ln -s /usr/include/libxml2/libxml/xmlexports.h /usr/include/xmlexports.h \
    && ln -s /usr/include/libxml2/libxml/xmlexports.h /usr/include/libxml/xmlexports.h \
    && git clone https://github.com/kirmarchenko/pyproxyhunter.git \
    && cd /pyproxyhunter \
    && pip install -r requirements.txt \
    && rm -rf /root/..?* /root/.[!.]* /root/* /tmp/*

VOLUME /opt

WORKDIR /pyproxyhunter

ENTRYPOINT ["docker-entrypoint.sh"]
