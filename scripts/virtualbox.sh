#!/bin/bash -x

# install dependencies
rpm -qa --qf "%{NAME}\n" > rpms-before
yum install -y make bzip2 gcc kernel-devel kernel-headers
rpm -qa --qf "%{NAME}\n" > rpms-after

# install virtualbox guest additions
VERSION=$(cat .vbox_version)
mount -o loop "VBoxGuestAdditions_${VERSION}.iso" /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

# clean up
rm -f .vbox_version && rm -f "VBoxGuestAdditions_${VERSION}.iso"
yum remove -y $(join -v 2 <(sort rpms-before) <(sort rpms-after))

# EOF
