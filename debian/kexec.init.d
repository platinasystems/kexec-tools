#! /bin/sh
### BEGIN INIT INFO
# Provides:		kexec
# Required-Start:	kexec-load
# Required-Stop:   
# Should-Start:
# Default-Start:
# Default-Stop:		6
# Short-Description: Execute the reboot command with kexec.
# Description:
### END INIT INFO

PATH=/usr/sbin:/usr/bin:/sbin:/bin

. /lib/lsb/init-functions

test -r /etc/default/kexec && . /etc/default/kexec

do_stop () {
    if [ "$USE_KEXEC" = 1 ]
    then
	log_action_msg "Will now restart"
        kexec -e
        log_failure_msg "kexec failed"
    fi
}

case "$1" in
  start)
	# No-op
	;;
  restart|reload|force-reload)
	echo "Error: argument '$1' not supported" >&2
	exit 3
	;;
  stop)
	do_stop
	;;
  *)
	echo "Usage: $0 start|stop" >&2
	exit 3
	;;
esac
