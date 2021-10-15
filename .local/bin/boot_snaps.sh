#!/usr/bin/env bash

VERSION=$(ls -v -1 /boot | tail -1 | cut -d'-' -f2)
boot="$ROOTDIR/boot/efi"
binaries="$boot/binaries"
snapshot_dir="/.snapshots"
number_of_snapshots=5
. "${ROOTDIR}/etc/default/efibootmgr-kernel-hook"

mkdir -p "$binaries"

snapshots=$(ls -1 "$snapshot_dir" | sort --numeric-sort | tail -$number_of_snapshots)

num_binaries=$(ls -1 $binaries | grep -v "void-*" | wc -l)

# To make life easy, just remove all snapshot efi entries first
efi=$(efibootmgr | grep "ROOT" | cut -c 5-8)
for e in $efi; do
	efibootmgr -q -b $e -B
done

prune() {
	diff=$(("$1" - number_of_snapshots))
	to_delete=$(ls -1 "$2" | grep -v "void-*" | head -$diff)

	for d in $to_delete; do
		rm -f "$d"
	done
}

[ "$num_binaries" -gt "$number_of_snapshots" ] && prune "$num_binaries" "$binaries"

for s in $snapshots; do
	new_options=${OPTIONS//rw rootflags=subvol=@/ro rootflags=subvol=@snapshots/$s}
	# Generate and sign new bundle
	sbctl bundle -c <(echo "$new_options") -p "$boot" -e /usr/lib/gummiboot/linuxx64.efi.stub -f /boot/initramfs-"$VERSION".img -k /boot/vmlinuz-"$VERSION" -o /etc/os-release "$binaries/$s".efi
	sbctl sign "$binaries/$s".efi

	efibootmgr -q --create --disk /dev/nvme0n1 --part 1 --label "$s" --loader "binaries\\$s.efi"
done

# Hopefully this never changes
efibootmgr -q -o 0000,0005,0004,0003,0002,0001
