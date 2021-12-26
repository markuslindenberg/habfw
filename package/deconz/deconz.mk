################################################################################
#
# deconz
#
################################################################################

DECONZ_VERSION = 2.12.06
DECONZ_SOURCE = deconz-$(DECONZ_VERSION)-qt5.deb
DECONZ_SITE = https://deconz.dresden-elektronik.de/raspbian/stable

define DECONZ_EXTRACT_CMDS
endef

define DECONZ_INSTALL_TARGET_CMDS
	$(AR) p $(DECONZ_DL_DIR)/$(DECONZ_SOURCE) data.tar.xz | $(TAR) -C $(TARGET_DIR) -J --wildcards $(TAR_OPTIONS) - './usr/lib/lib*' './usr/share/deCONZ/' './usr/bin/GCFFlasher*' './usr/bin/deCONZ'
	$(INSTALL) -D -m 644 $(DECONZ_PKGDIR)/conbee.rules $(TARGET_DIR)/etc/udev/rules.d/69-conbee.rules
	$(INSTALL) -D -m 755 $(DECONZ_PKGDIR)/deconz-disable-announce $(TARGET_DIR)/usr/bin/deconz-disable-announce
	$(INSTALL) -D -m 644 $(OPENHAB_PKGDIR)/tmpfiles.conf $(TARGET_DIR)/etc/tmpfiles.d/100-deconz.conf
endef

define DECONZ_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(DECONZ_PKGDIR)/deconz.service $(TARGET_DIR)/lib/systemd/system/deconz.service
endef

define DECONZ_USERS
	deconz 1001 deconz 1001 * - - -
endef

$(eval $(generic-package))
