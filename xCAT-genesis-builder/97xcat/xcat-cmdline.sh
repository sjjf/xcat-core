#!/bin/bash
#
# add a cmdline entry configuring syslog to point to the xCAT server

# shellcheck disable=1091
type getarg > /dev/null 2>&1 || . /lib/dracut-lib.sh
echo "xCAT: processing kernel command line"
cmdline=$(getcmdline)
echo "xCAT: initial command line"
echo "$cmdline"

echo "xCAT: getting xcatd IP for syslog"
xcatd=$(getarg xcatd)
xcat_ip=${xcatd%:*}

# drop in configuration for the syslog module - the server IP and a more
# useful set of filters than the default (which is kern.*)
echo "syslog.server=$xcat_ip" >>/etc/cmdline.d/xcat-cmdline.conf
echo "*.*" >/tmp/syslog.filters

# some fiddling of the hostname, so that we can avoid annoying log messages
#
# Note: only do this when destiny is discover, since in any other context we
# can expect there to be a proper host entry for the node, which will give it
# a proper name.
destiny=$(getarg destiny)
bootif=$(getarg BOOTIF)
if [ "$destiny" = "discover" ]; then
        hostname="${bootif/01/discover}"
        echo "$hostname" > /proc/sys/kernel/hostname
fi

# this is necessary for dracut to proceed beyond this hook.
# shellcheck disable=2034
root='initramfs'
# shellcheck disable=2034
rootok=1

echo "xCAT: done parsing cmdline"
echo "xCAT: new cmdline"
cmdline=$(getcmdline)
echo "$cmdline"
