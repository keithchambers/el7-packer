all: build

build:
	packer build -force ./src/CentOS-7-x86_64.json

install:
	vagrant box add CentOS-7-x86_64-virtualbox.box --name CentOS-7-x86_64

clean:
	rm -f CentOS-7-x86_64-virtualbox.box
	rm -rf output-virtualbox-iso
