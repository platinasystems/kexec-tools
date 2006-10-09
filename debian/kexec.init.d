#! /bin/sh
### BEGIN INIT INFO
# Provides:		kexec
# Required-Start:	kexec-load
# Required-Stop:   	kexec-load
# Should-Start:
# Should-Stop:
# Default-Start:	0 1 2 3 4 5
# Default-Stop:		6
# Short-Description: Execute the kexec -e command to reboot system
# Description:
### END INIT INFO

PATH=/usr/sbin:/usr/bin:/sbin:/bin

. /lib/lsb/init-functions

test -r /etc/default/kexec && . /etc/default/kexec

do_stop () {
	test "$USE_KEXEC" = 1 || exit 0
	test -x /sbin/kexec || exit 0

	log_action_msg "Will now restart with kexec"
        kexec -e
        log_failure_msg "kexec failed"
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
exit 0
