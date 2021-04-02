#!/bin/sh

set -u
set -e

mkdir -p ${TARGET_DIR}/boot

rm -rf ${TARGET_DIR}/usr/share/factory/var
cp -dpfr ${TARGET_DIR}/var ${TARGET_DIR}/usr/share/factory/

cat << EOF > ${TARGET_DIR}/etc/os-release
NAME=habfw
ID=habfw
ID_LIKE=buildroot
PRETTY_NAME="habfw (Buildroot ${BR2_VERSION})"
EOF

if [ -n "${GITHUB_SHA:-}" ]; then
    echo "VERSION_ID=${GITHUB_SHA}" >> ${TARGET_DIR}/etc/os-release 
fi

sed -i 's/\#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/var\/lib\/ssh\/ssh_host_rsa_key/' ${TARGET_DIR}/etc/ssh/sshd_config
sed -i 's/\#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/var\/lib\/ssh\/ssh_host_ecdsa_key/' ${TARGET_DIR}/etc/ssh/sshd_config
sed -i 's/\#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/var\/lib\/ssh\/ssh_host_ed25519_key/' ${TARGET_DIR}/etc/ssh/sshd_config
