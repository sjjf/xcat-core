#!/bin/bash
#
# add a cmdline entry configuring syslog to point to the xCAT server

type getarg > /dev/null 2>&1 || . /lib/dracut-lib.sh

xcatd=$(getarg xcatd)
xcat_ip=${xcatd%:*}

echo "syslog.server=$xcat_ip" >>/etc/cmdline.d/xcat-cmdline.conf

