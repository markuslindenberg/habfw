################################################################################
#
# openhab
#
################################################################################

OPENHAB_VERSION = 3.2.0
OPENHAB_SOURCE = openhab-$(OPENHAB_VERSION).zip
OPENHAB_SITE = https://openhab.jfrog.io/artifactory/libs-release-local/org/openhab/distro/openhab/$(OPENHAB_VERSION)
OPENHAB_LICENSE = EPL-2.0
OPENHAB_LICENSE_FILES = LICENSE.TXT
OPENHAB_INSTALL_BASE = /opt/openhab

define OPENHAB_EXTRACT_CMDS
	$(UNZIP) -o $(OPENHAB_DL_DIR)/$(OPENHAB_SOURCE) -d $(@D)
endef

define OPENHAB_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)$(OPENHAB_INSTALL_BASE)
	find $(@D) -mindepth 1 -maxdepth 1 '!' -name '.*' '!' -name 'start*' -execdir cp -dpfr -t $(TARGET_DIR)$(OPENHAB_INSTALL_BASE) '{}' +
	$(INSTALL) -D -m 644 $(OPENHAB_PKGDIR)/tmpfiles.conf $(TARGET_DIR)/etc/tmpfiles.d/100-openhab.conf
endef

define OPENHAB_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(OPENHAB_PKGDIR)/openhab.default $(TARGET_DIR)/etc/default/openhab
	$(INSTALL) -D -m 644 -t $(TARGET_DIR)/usr/lib/systemd/system \
		$(OPENHAB_PKGDIR)/openhab.service
endef

define OPENHAB_USERS
	openhab 1000 openhab 1000 * - - -
endef

$(eval $(generic-package))
