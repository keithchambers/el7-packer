#!/bin/bash -x

# delete interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules

# remove uuid and mac address
sed -i '/UUID/d' /etc/sysconfig/network-scripts/ifcfg-e*
sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-e*

# delete yum files
yum clean all
rm -rf /var/lib/yum/yumdb/*
rm -rf /var/lib/yum/history/*
rm -rf /var/cache/*
rm -rf /var/tmp/*
rm -rf /tmp/*
find /usr/lib/python2.7/site-packages -name '*.pyc' -delete

# delete files in home
find "${HOME}" -type f -delete

# delete log files
find /var/log -type f -delete

# zero out empty space
dd if=/dev/zero of=/ZERO bs=1M
rm -rf /ZERO
sync

# EOF
