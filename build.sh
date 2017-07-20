#!/bin/bash
cd $(dirname "${BASH_SOURCE[0]}")
repo_path='./controller'

mkdir -p $repo_path/kll/layouts/
cp src/Layers/* $repo_path/kll/layouts/ || exit 1
cp src/ergodox-custom.sh $repo_path/Keyboards/ || exit 1

(cd $repo_path/Keyboards && ./ergodox-custom.sh) || exit 1

timestamp=$(date -u +"%Y-%m-%dT%H.%M.%SZ")
out_dir=bin/$timestamp
mkdir -p $out_dir

cp $repo_path/Keyboards/ICED-L.gcc/kiibohd.dfu.bin $out_dir/left.bin
cp $repo_path/Keyboards/ICED-R.gcc/kiibohd.dfu.bin $out_dir/right.bin
cp -r ./src/* $out_dir

echo -n "Flash right? [y/N] "
read -n 1 flash_right
echo
if [[ $flash_right =~ [yY] ]]; then
	./flash.sh $out_dir/right.bin
fi
