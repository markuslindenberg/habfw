#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
install -D -m 0644 "${BOARD_DIR}/config.txt" "${BINARIES_DIR}/config-common.txt"
install -D -m 0644 "${BOARD_DIR}/cmdline.txt" "${BINARIES_DIR}/cmdline.txt"
install -D -m 0755 "${BOARD_DIR}/rauc-hooks.sh" "${BINARIES_DIR}/rauc-hooks.sh"

# use self signed certifiate
[[ -f "${BINARIES_DIR}/habfw.cert.pem" ]] || openssl req -x509 -newkey rsa:4096 -nodes -keyout "${BINARIES_DIR}/habfw.key.pem" -out "${BINARIES_DIR}/habfw.cert.pem" -subj "/O=habfw/CN=habfw-update"

rm -f "${BINARIES_DIR}/overlays.tar"
tar -C "${BINARIES_DIR}/rpi-firmware/overlays" -c -f "${BINARIES_DIR}/overlays.tar" .

rm -rf "${BINARIES_DIR}/image0"
mkdir -p "${BINARIES_DIR}/image0"
cp -r -t "${BINARIES_DIR}/image0" "${BINARIES_DIR}/rpi-firmware/overlays"
echo -e "root=/dev/mmcblk0p2 $(<${BINARIES_DIR}/cmdline.txt)" > "${BINARIES_DIR}/image0/cmdline.txt"
echo -e "os_prefix=image0/\n$(<${BINARIES_DIR}/config-common.txt)" > "${BINARIES_DIR}/config.txt"

RAUC_MANIFEST=$(cat <<EOM
[update]
compatible=habfw-raspberrypi4
version=${GITHUB_SHA:-snapshot}
build=${GITHUB_SHA:-snapshot}

[bundle]
format=verity

[hooks]
filename=hook

[image.rootfs]
filename=rootfs.img
hooks=post-install
EOM
)
export RAUC_MANIFEST

# generate images

GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
rm -rf "${GENIMAGE_TMP}"
genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${BOARD_DIR}/genimage.cfg"

exit $?
