#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"

packages="cmake exuberant-ctags libusb-1.0-0-dev binutils-arm-none-eabi gcc-arm-none-eabi libnewlib-arm-none-eabi"

if [[ ! -z $(dpkg-query --show --showformat '${db:Status-Status}\n' $packages 2>&1 | grep -v installed) ]]; then
	sudo apt-get install $packages || exit 1
fi

cd controller
test ! -e kll && (ln -s ../kll || exit 1)

echo "Ready!"
