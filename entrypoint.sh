#!/bin/bash
set -eo pipefail

echo "Taking a nap, to allow weave network to properly set up.."
sleep 20
echo "That was a good nap. Now to work..."


grep -r -l {{LOGSTASH_SERVER}}  $basedir/etc/collectd.d/*.conf | xargs sed -i "s/{{LOGSTASH_SERVER}}/$LOGSTASH_SERVER/g" 
grep -r -l {{LOGSTASH_PORT}}    $basedir/etc/collectd.d/*.conf | xargs sed -i "s/{{LOGSTASH_PORT}}/$LOGSTASH_PORT/g"
sed -i "s/{{HOSTNAME}}/$HOSTNAME/g" $basedir/etc/collectd.conf
sed -i "s:{{basedir}}:$basedir:g" $basedir/etc/collectd.conf

exec $basedir/sbin/collectd -f
