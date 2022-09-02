#!/usr/bin/bash

# called by dracut
check() {
    require_binaries chronyd || return 1
    return 255
}

# called by dracut
depends() {
    echo network
    return 0
}

# called by dracut
install() {
    inst chronyd
    inst "$moddir/chrony.conf" /etc/chrony.conf
    inst "$moddir/chrony.keys" /etc/chrony.keys
    inst_hook initqueue/online 10 "$moddir/xcat-chronyd-start.sh"
}
