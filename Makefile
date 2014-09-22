all: build install clean

build:
	packer build -force -only=virtualbox-iso ./src/centos7.json

install:
	vagrant box add centos7_virtualbox.box --name centos7 --provider=virtualbox

clean:
        rm -f centos7_virtualbox.box
	rm -rf packer_cache
	rm -rf output-virtualbox-iso
