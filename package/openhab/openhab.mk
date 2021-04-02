################################################################################
#
# openhab
#
################################################################################

OPENHAB_VERSION = 3.0.1
OPENHAB_SOURCE = openhab-$(OPENHAB_VERSION).zip
OPENHAB_SITE = https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab/$(OPENHAB_VERSION)
OPENHAB_LICENSE = EPL-2.0
OPENHAB_LICENSE_FILES = LICENSE.TXT

define OPENHAB_EXTRACT_CMDS
endef

define OPENHAB_INSTALL_TARGET_CMDS
	$(MKDIR) -p $(TARGET_DIR)/opt/openhab
	$(UNZIP) -o $(OPENHAB_DL_DIR)/$(OPENHAB_SOURCE) -d $(TARGET_DIR)/opt/openhab -x 'start*'
endef

define OPENHAB_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(OPENHAB_PKGDIR)/openhab.default $(TARGET_DIR)/etc/default/openhab
	$(INSTALL) -D -m 644 -t $(TARGET_DIR)/usr/lib/systemd/system \
		$(OPENHAB_PKGDIR)/openhab.service
endef

$(eval $(generic-package))
