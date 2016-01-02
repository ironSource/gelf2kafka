#!/bin/bash

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

NAME="gelf2kafka"

DESC="${NAME} Producer"

USER=root
DAEMON=/opt/ruby/embedded/bin/${NAME}

LOGDIR="/var/log/${NAME}"

PIDFILE="/var/run/${NAME}.pid"
LOCKFILE="/var/run/lock/${NAME}"
WORKDIR="/tmp"
SHUTDOWN_TIMEOUT=1

GELF2KAFKA_OPTS="--config /etc/sonic/${NAME}.yaml"

[ -e /etc/default/${NAME} ] && . /etc/default/${NAME}

. /lib/lsb/init-functions

function rotate-sonic-log() {

        local logdir=$1

        LOGROTATE_CONF=${logdir}/logrotate.conf

        if [ ! -e $LOGROTATE_CONF ]; then
                cat > $LOGROTATE_CONF <<EOF
missingok
rotate 10
compress
delaycompress
create

"${logdir}/stdout" "${logdir}/stderr" {
}
EOF
        fi

        /usr/sbin/logrotate -f $LOGROTATE_CONF
}

start() {
        rotate-sonic-log $LOGDIR

        ulimit -n 10240
        log_daemon_msg "Starting $DESC: "
        daemonize -c $WORKDIR -u $USER -p $PIDFILE -l $LOCKFILE -o $LOGDIR/stdout -e $LOGDIR/stderr $DAEMON $GELF2KAFKA_OPTS
        log_end_msg $?
}
stop(){
        [ -e "$PIDFILE" ] && [ ! -z "$(cat $PIDFILE)" ] && test -d "/proc/$(cat $PIDFILE)" && kill -SIGTERM $(cat $PIDFILE)
        log_daemon_msg "Stopping $DESC: "
        flock --exclusive --timeout $SHUTDOWN_TIMEOUT $LOCKFILE --command "echo -n"
        log_end_msg $?
}

case "$1" in
        start)
                start
                ;;
        stop)
                stop
                ;;

        restart)
                stop
                sleep 0.1
                start
                ;;
        *)
                echo "Usage: $SCRIPTNAME {start|stop|restart}" >&2
                exit 1
                ;;
esac

exit 0
