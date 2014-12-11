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

RUN grep -r -l {{LOGSTASH_SERVER}}  /etc/collectd/collectd.d/*.conf | xargs sed -i "s/{{LOGSTASH_SERVER}}/$LOGSTASH_SERVER/g" && \
	grep -r -l {{LOGSTASH_PORT}}    /etc/collectd/collectd.d/*.conf | xargs sed -i "s/{{LOGSTASH_PORT}}/$LOGSTASH_PORT/g" && \
 	sed -i "s/{{HOSTNAME}}/$HOSTNAME/g" /etc/collectd/collectd.conf

CMD exec collectd -f
