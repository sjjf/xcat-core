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
cat >>/etc/passwd <<"__ENDL"
root:x:0:0::/:/bin/bash
sshd:x:30:30:SSH User:/var/empty/sshd:/sbin/nologin
rpc:x:32:32:Rpcbind Daemon:/var/cache/rpcbind:/sbin/nologin
rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
qemu:x:107:107:qemu user:/:/sbin/nologin
chrony:x:995:991::/var/lib/chrony:/sbin/nologin
__ENDL

# since we're referring to shadow in our passwd file, we may as well set this
# up as well
cat <<"__ENDL" >>/etc/shadow
root:!::0:99999:7:::
sshd:!::0:99999:7:::
rpc:!::0:99999:7:::
rpcuser:!::0:99999:7:::
qemu:!::0:99999:7:::
chrony:!::0:99999:7:::
__ENDL

echo "xCAT: running doxcat in screen session"

cmdline=$(getcmdline)
if echo $cmdline |grep console=ttyS >/dev/null; then
        while :; do sleep 1; screen -S console -ln screen -x doxcat </dev/tty1 &>/dev/tty1; clear &>/dev/tty1 ; done &
fi
while :; do screen -ln < /dev/tty2 &> /dev/tty2 ; done &

while :; do screen -dr doxcat </dev/console &>/dev/console || screen -S doxcat -L -ln doxcat </dev/console &>/dev/console ; done
