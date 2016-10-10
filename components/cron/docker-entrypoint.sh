#!/bin/sh
chmod -R +x /etc/periodic
exec $@
exit $?
