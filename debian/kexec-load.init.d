#! /bin/sh
### BEGIN INIT INFO
# Provides:		kexec-load
# Required-Start:	$local_fs
# Required-Stop:	$local_fs
# Should-Start:
# Should-Stop:
# Default-Start:	0 1 2 3 4 5
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
	if [ -z "$INITRD" ]
	then
		kexec -l "$KERNEL_IMAGE" --append="$REAL_APPEND"
	else
		kexec -l "$KERNEL_IMAGE" --initrd="$INITRD" --append="$REAL_APPEND"
	fi
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
exit 0
