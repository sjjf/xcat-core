#!/bin/bash
#
# add a cmdline entry configuring syslog to point to the xCAT server

type getarg > /dev/null 2>&1 || . /lib/dracut-lib.sh
echo "xCAT: processing kernel command line"
cmdline=$(getcmdline)
echo "xCAT: initial command line"
echo "$cmdline"

echo "xCAT: getting xcatd IP for syslog"
xcatd=$(getarg xcatd)
xcat_ip=${xcatd%:*}

echo "syslog.server=$xcat_ip" >>/etc/cmdline.d/xcat-cmdline.conf

# this is necessary for dracut to proceed beyond this hook.
root='initramfs'
rootok=1

echo "xCAT: done parsing cmdline"
echo "xCAT: new cmdline"
cmdline=$(getcmdline)
echo "$cmdline"
