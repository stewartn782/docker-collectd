FROM debian:jessie

ENV COLLECTD_VERSION 5.5.2
WORKDIR /usr/src/

ADD collectd.conf /etc/collectd/
ADD entrypoint.sh /entrypoint.sh

RUN echo '5d850b1b91cb88dd784a552f6f0dbee8ee76300f  collectd-5.5.2.tar.bz2' > /tmp/collectd.sig && \
    apt-get update && apt-get install -y build-essential wget tar lbzip2 && \
    wget https://collectd.org/files/collectd-$COLLECTD_VERSION.tar.bz2 && \
    shasum -a 1 -c /tmp/collectd.sig && \
    tar xf collectd-$COLLECTD_VERSION.tar.bz2 && \
    cd collectd-$COLLECTD_VERSION && \
    ./configure && make && make install && cd - \
    rm -rf /usr/src/collectd /usr/src/collectd-$COLLECTD_VERSION* /var/lib/apt/lists/* && \
    apt-get autoremove -y build-essential

ENTRYPOINT ["/entrypoint.sh"]
