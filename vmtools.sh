#!/bin/bash -eux

# install linux kernel headers
sudo yum install -y make bzip2 gcc kernel-devel kernel-headers

case "$PACKER_BUILDER_TYPE" in

virtualbox-iso|virtualbox-ovf)
    mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt
    sh /mnt/VBoxLinuxAdditions.run
    umount /mnt
    ;;

vmware-iso|vmware-vmx) 
    sudo yum install -y perl nfs-utils
    mkdir /mnt/vmfusion
    mkdir /mnt/vmfusion-archive
    mount -o loop /home/vagrant/linux.iso /mnt/vmfusion
    tar xzf /mnt/vmfusion/VMwareTools-*.tar.gz -C /tmp/vmfusion-archive
    /mnt/vmfusion-archive/vmware-tools-distrib/vmware-install.pl --default
    umount /mnt/vmfusion
    rm -rf /mnt/vmfusion
    rm -rf /mnt/vmfusion-archive
    ;;

*)
    echo "Unknown Packer Builder Type >>$PACKER_BUILDER_TYPE<< selected."
    echo "Known are virtualbox-iso|virtualbox-ovf|vmware-iso|vmware-ovf."
    ;;

esac

# remove linux kernel headers
yum -y remove gcc kernel-devel kernel-headers
yum -y clean all

# remove virtualbox specific files
rm -rf *.iso /tmp/vbox /home/vagrant/.vbox_version

# EOF
