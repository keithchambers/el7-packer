#!/bin/bash
set -x

yum clean all

find /var/log -type f -delete

rm -rf /tmp/*

# clean up interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules

# zero out empty space
dd if=/dev/zero of=/EMPTY bs=1M
rm -rf /EMPTY
sync

# EOF
