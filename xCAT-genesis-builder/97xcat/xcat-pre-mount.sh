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
sed -i '/^root:x/d' /etc/passwd
cat >>/etc/passwd <<"__ENDL"
root:x:0:0::/:/bin/bash
sshd:x:30:30:SSH User:/var/empty/sshd:/sbin/nologin
rpc:x:32:32:Rpcbind Daemon:/var/cache/rpcbind:/sbin/nologin
rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
qemu:x:107:107:qemu user:/:/sbin/nologin
chrony:x:995:991::/var/lib/chrony:/sbin/nologin
__ENDL

echo "xCAT: running doxcat in screen session"

cmdline=$(getcmdline)
if echo $cmdline |grep grep console=ttyS >/dev/null; then
        while :; do sleep 1; screen -S console -ln screen -x doxcat </dev/tty1 &>/dev/tty1; clear &>/dev/tty1 ; done &
fi
while :; do screen -ln < /dev/tty2 &> /dev/tty2 ; done &

while :; do screen -dr doxcat || screen -S doxcat -L -ln doxcat; done
