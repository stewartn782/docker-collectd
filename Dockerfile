FROM debian:buster-slim

ENV COLLECTD_VERSION 5.12.0
WORKDIR /usr/src/

ADD collectd.conf /etc/collectd/
ADD entrypoint.sh /entrypoint.sh

RUN echo '5bae043042c19c31f77eb8464e56a01a5454e0b39fa07cf7ad0f1bfc9c3a09d6  collectd-5.12.0.tar.bz2' > /tmp/collectd.sig && \
    sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y apt-utils build-essential wget tar lbzip2 libgcrypt-dev libsnmp-dev snmp-mibs-downloader && \
    wget https://collectd.org/files/collectd-$COLLECTD_VERSION.tar.bz2 && \
    shasum -a 1 -c /tmp/collectd.sig && \
    tar xf collectd-$COLLECTD_VERSION.tar.bz2 && \
    cd collectd-$COLLECTD_VERSION && \
    ./configure --enable-network --enable-snmp && make && make install && cd - \
    rm -rf /usr/src/collectd /usr/src/collectd-$COLLECTD_VERSION* /var/lib/apt/lists/* && \
    apt-get autoremove -y build-essential

ENTRYPOINT ["/entrypoint.sh"]
