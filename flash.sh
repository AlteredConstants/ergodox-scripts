#!/bin/bash
firmware_file=$1
cd $(dirname "${BASH_SOURCE[0]}")

wait_for_ready="while ! ./kii-dfu/dfu-util.exe --list | grep -q 'Kiibohd DFU';do sleep 1;done"

echo "Waiting for device..."
if timeout 10 bash -c "$wait_for_ready"; then
	./kii-dfu/dfu-util.exe --download "$(convert-path -w "$firmware_file")"
else
	echo "Failed to find device after 10 seconds."
	exit 1
fi
