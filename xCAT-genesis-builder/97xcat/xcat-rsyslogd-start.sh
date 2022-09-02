#!/usr/bin/sh
#
# This is a modified version of the syslog module rsyslogd-star.sh script, to
# resolve an issue with the use of the `-c` option to rsyslogd, which isn't
# recognised by current versions (and I have no idea why it keeps being used
# by tools like this).

# Triggered by initqueue/online and starts rsyslogd with bootparameters

type getarg > /dev/null 2>&1 || . /lib/dracut-lib.sh

# prevent starting again if already running
if [ -f /var/run/syslogd.pid ]; then
    read -r pid < /var/run/syslogd.pid
    kill -0 "$pid" && exit 0
fi

rsyslog_config() {
    local server=$1
    shift
    local syslog_template=$1
    shift
    local filters=$*
    local filter=

    cat "$syslog_template"

    (
        # disable shell expansion / globbing
        # since filters contain such characters
        set -f
        for filter in $filters; do
            echo "${filter} @${server}"
        done
    )
    #echo "*.* /tmp/syslog"
}

[ -f /tmp/syslog.type ] && read -r type < /tmp/syslog.type
[ -f /tmp/syslog.server ] && read -r server < /tmp/syslog.server
[ -f /tmp/syslog.filters ] && read -r filters < /tmp/syslog.filters
[ -z "$filters" ] && filters="kern.*"
[ -f /tmp/syslog.conf ] && read -r conf < /tmp/syslog.conf
[ -z "$conf" ] && conf="/etc/rsyslog.conf" && echo "$conf" > /tmp/syslog.conf

if [ "$type" = "rsyslogd" ]; then
    template=/etc/templates/rsyslog.conf
    if [ -n "$server" ]; then
        rsyslog_config "$server" "$template" "$filters" > $conf
        rsyslogd
    fi
fi

# this is a pain, but it cleans up an annoying error
if [ -e "$hookdir/initqueue/online/70-rsyslogd-start.sh" ]; then
    rm -f "$hookdir/initqueue/online/70-rsyslogd-start.sh"
fi
