#!/bin/bash -x

# install dependencies
RPMS_PRE=$(rpm -qa --qf "%{NAME}\n" | sort)
yum install -y make bzip2 gcc kernel-devel kernel-headers

# install virtualbox guest additions
VERSION=$(cat .vbox_version)
mount -o loop "VBoxGuestAdditions_${VERSION}.iso" /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

# clean up
RPMS_POST=$(rpm -qa --qf "%{NAME}\n" | sort)
yum remove -y $(join -v 2 <(echo "${RPMS_PRE}") <(echo "${RPMS_POST}"))
rm -f .vbox_version && rm -f "VBoxGuestAdditions_${VERSION}.iso"

# EOF
