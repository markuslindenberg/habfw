################################################################################
#
# zram-tools
#
################################################################################

ZRAM_TOOLS_VERSION = 0.3.3.1
ZRAM_TOOLS_SOURCE = zram-tools_$(ZRAM_TOOLS_VERSION).orig.tar.gz
ZRAM_TOOLS_SITE = https://snapshot.debian.org/archive/debian/20210328T091458Z/pool/main/z/zram-tools
ZRAM_TOOLS_LICENSE = ISC
ZRAM_TOOLS_LICENSE_FILES = COPYING

define ZRAM_TOOLS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 -t $(TARGET_DIR)/etc/default $(@D)/conf/zramswap
	$(INSTALL) -D -m 755 -t $(TARGET_DIR)/usr/sbin $(@D)/zramswap
endef

define ZRAM_TOOLS_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 -t $(TARGET_DIR)/usr/lib/systemd/system $(@D)/zramswap.service
endef

$(eval $(generic-package))
