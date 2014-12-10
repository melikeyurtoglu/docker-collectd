FROM yaronr/debian-wheezy
MAINTAINER yaronr

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends collectd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD collectd.conf.tpl /usr/local/etc/collectd.conf.tpl
ADD collectd.d /usr/local/etc/collectd.d
ADD btrfs-data.py /usr/local/bin/btrfs-data.py

CMD for template in /usr/local/etc/collectd.conf.tpl /usr/local/etc/collectd.d/*.tpl ; do envtpl $template ; done && exec collectd -f
