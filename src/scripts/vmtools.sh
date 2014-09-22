#!/bin/bash
set -ex

function install-kernel-headers()
{
    rpm -qa > rpms-before
    yum install make bzip2 gcc kernel-devel kernel-headers --assumeyes
    rpm -qa > rpms-after
}

function remove-kernel-headers()
{
    yum remove $(join -v 2 <(sort rpms-before) <(sort rpms-after)) --assumeyes
    rm -f rpms-before rpms-after
}

case "${PACKER_BUILDER_TYPE}" in
    virtualbox-iso|virtualbox-ovf)
        install-kernel-headers
        VERSION=$(cat /home/vagrant/.vbox_version)
        mount -o loop /home/vagrant/VBoxGuestAdditions_${VERSION}.iso /mnt
        sh /mnt/VBoxLinuxAdditions.run
        umount /mnt
        ;;
    vmware-iso|vmware-vmx) 
        yum install perl nfs-utils --assumeyes
        install-kernel-headers
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
        echo "Error: unknown Packer builder type ${PACKER_BUILDER_TYPE}."
        echo "Known are virtualbox-iso|virtualbox-ovf|vmware-iso|vmware-ovf."
        exit 1
        ;;
esac

# remove extra rpms
remove-kernel-headers

# remove virtualbox specific files
rm -rf *.iso /tmp/vbox /home/vagrant/.vbox_version

# EOF
