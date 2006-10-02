#! /bin/sh
### BEGIN INIT INFO
# Provides:		kexec-load
# Required-Start:
# Required-Stop:
# Should-Start:
# Should-Stop:
# Default-Start:
# Default-Stop:		6
# Short-Description: Load kernel image with kexec
# Description:
### END INIT INFO

PATH=/usr/sbin:/usr/bin:/sbin:/bin

. /lib/lsb/init-functions

test -r /etc/default/kexec && . /etc/default/kexec

do_stop () {
	test "$USE_KEXEC" = 1 || exit 0
	test -x /sbin/kexec || exit 0

	REAL_APPEND="$APPEND"

	test -z "$REAL_APPEND" && REAL_APPEND="`cat /proc/cmdline`"
	log_action_begin_msg "Loading new kernel image into memory"
	kexec -l "$KERNEL_IMAGE" --initrd="$INITRD" --append="$REAL_APPEND"
	log_action_end_msg $?
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
