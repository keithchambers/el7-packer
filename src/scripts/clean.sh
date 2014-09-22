#!/bin/bash
set -ex

# rpm -Va reports / and /var/run/wpa_supplicant as modified
yum reinstall wpa_supplicant filesystems --assumeyes 
yum clean all

# clean up log files
find /var/log -type f -delete

# remove under tmp directory
rm -rf /tmp/*

# clean up interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules

# zero out empty space
dd if=/dev/zero of=/EMPTY bs=1M
rm -rf /EMPTY
sync

# EOF
