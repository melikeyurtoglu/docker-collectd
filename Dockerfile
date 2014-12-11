FROM yaronr/debian-wheezy
MAINTAINER yaronr

ENV LOGSTASH_SERVER logstash
ENV LOGSTASH_PORT 25826
#ENV HOSTNAME -PLEASE SUPPLY!-

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends collectd libcurl4-openssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
 #   python btrfs-tools && \

RUN rm /etc/collectd/*.*
ADD collectd.conf /etc/collectd/collectd.conf
ADD collectd.d /etc/collectd/collectd.d
#ADD btrfs-data.py /usr/local/bin/btrfs-data.py
ADD entrypoint.sh /collectd_entrypoint.sh
RUN chmod a+x /collectd_entrypoint.sh

CMD /collectd_entrypoint.sh
