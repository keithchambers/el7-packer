#!/bin/bash
set -x

# yum
yum clean all

# delete logs
find /var/log -type f -delete

# delete /tmp
rm -rf /tmp/*

# delete files in home
rm -rf $HOME/*

# delete interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules

# remove uuid and mac address
sed -i '/UUID/d' /etc/sysconfig/network-scripts/ifcfg-e*
sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-e*

# zero out empty space
dd if=/dev/zero of=/ZERO bs=1M
rm -rf /ZERO

# EOF
