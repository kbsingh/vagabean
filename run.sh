#!/bin/bash

# check we are on centos7
# check we are being run as root

if [ "z$1" = "z--help" ] || [ $# -lt 1 ]
then
        echo "run.sh <vbox|libvirt>"
        exit 255
fi

provider=$1

case "$provider" in
"libvirt")
        echo "Running test on libvirt provider"
        bash ./run_vagrant_libvirt.sh
        ;;
"vbox")
        echo "Running test on virtualbox provider"
        bash ./run_vagrant_vbox.sh
        ;;
*)
        echo "Invalid option"
        ;;
esac
