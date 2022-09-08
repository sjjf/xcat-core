#!/usr/bin/bash
#
# run doxcat
#
# This will run before any attempt is made to mount the new root (which
# doesn't exist), and simply set up and run the xCAT scripts

type getarg > /dev/null 2>&1 || . /lib/dracut-lib.sh

echo PS1="'"'[xCAT Genesis running on \H \w]\$ '"'" > /.bashrc
echo PS1="'"'[xCAT Genesis running on \H \w]\$ '"'" > /.bash_profile
mkdir -p /etc/ssh
mkdir -p /var/tmp/
mkdir -p /var/empty/sshd
# note that this regex is only going to match in hostonly mode - otherwise
# /etc/shadow is empty and so is the password entry. So instead we need to
# get a bit more brutal . . .
#sed -i '/^root:x/d' /etc/passwd
sed -i '/^root:/d' /etc/passwd
echo 'root:x:0:0::/:/bin/bash' >>/etc/passwd
if ! grep -q '^root:' /etc/shadow ; then
        echo 'root:!::0:99999:7:::' >>/etc/shadow
fi

echo "xCAT: running doxcat in screen session"

cmdline=$(getcmdline)
if echo "$cmdline" |grep console=ttyS >/dev/null; then
        while :; do sleep 1; screen -S console -ln screen -x doxcat </dev/tty1 &>/dev/tty1; clear &>/dev/tty1 ; done &
fi
while :; do screen -ln < /dev/tty2 &> /dev/tty2 ; done &

while :; do screen -dr doxcat </dev/console &>/dev/console || screen -S doxcat -L -ln doxcat </dev/console &>/dev/console ; done
