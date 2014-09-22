all:
	packer build -force ./src/centos7.json

build-virtualbox:
	packer build -force -only=virtualbox-iso ./src/centos7.json

build-vmware:
	packer build -force -only=vmware-iso ./src/centos7.json

import-virtualbox:
	vagrant box add centos7_virtualbox.box --name centos7 --provider=virtualbox

import-vmware:
	vagrant box add centos7_vmware.box --name centos7 --provider=vmware

clean:
	rm -rf ./centos7_virtualbox.box
	rm -rf ./centos7_vmware.box
	rm -rf ./packer_cache
	rm -rf ./output-virtualbox-iso
	rm -rf ./output-vmware-iso
