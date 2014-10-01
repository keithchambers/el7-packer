all: build

build:
	packer build -force ./src/centos7.json

install:
	vagrant box add centos7-virtualbox.box --name centos7

clean:
	rm -f centos7-virtualbox.box
	rm -rf output-virtualbox-iso
