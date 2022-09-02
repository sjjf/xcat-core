#!/usr/bin/sh

type getarg > /dev/null 2>&1 || . /lib/dracut-lib.sh

# make sure we're not running
if [ -f /var/run/chrony/chronyd.pid ]; then
    read -r pid < /var/run/chrony/chronyd.pid
    kill -0 "$pid" && exit 0
fi

# we want to get the ntp server from dhcp, if it's available
BOOTIF=$(getarg BOOTIF)
bootif=$(echo $BOOTIF |sed -e s/01-// -e s/-/:/g)
if [ -e /tmp/dhclient.$bootif.dhcpopts ]; then
    . /tmp/dhclient.$bootif.dhcpopts
fi

if [ -n "$new_ntp_servers" ]; then
    for server in $new_ntp_servers; do
        echo "server $server iburst" >> /etc/chrony.conf
    done
else
    echo "pool pool.ntp.org iburst maxsources 3" >> /etc/chrony.conf
fi

chronyd
