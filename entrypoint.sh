#!/bin/bash

echo "Taking a nap, to allow weave network to properly set up.."
sleep 20
echo "That was a good nap. Now to work..."

grep -r -l {{LOGSTASH_SERVER}}  /etc/collectd/collectd.d/*.conf | xargs sed -i "s/{{LOGSTASH_SERVER}}/$LOGSTASH_SERVER/g" 
grep -r -l {{LOGSTASH_PORT}}    /etc/collectd/collectd.d/*.conf | xargs sed -i "s/{{LOGSTASH_PORT}}/$LOGSTASH_PORT/g"
sed -i "s/{{HOSTNAME}}/$HOSTNAME/g" /etc/collectd/collectd.conf

exec collectd -f