################################################################################
#
# openhab-addons
#
################################################################################

OPENHAB_ADDONS_VERSION = 3.1.0.M3
OPENHAB_ADDONS_SOURCE = openhab-addons-$(OPENHAB_ADDONS_VERSION).kar
OPENHAB_ADDONS_SITE = https://openhab.jfrog.io/artifactory/libs-milestone-local/org/openhab/distro/openhab-addons/$(OPENHAB_ADDONS_VERSION)
OPENHAB_ADDONS_LICENSE = EPL-2.0

define OPENHAB_ADDONS_EXTRACT_CMDS
endef

define OPENHAB_ADDONS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(OPENHAB_ADDONS_DL_DIR)/$(OPENHAB_ADDONS_SOURCE) $(TARGET_DIR)/opt/openhab/addons/$(OPENHAB_ADDONS_SOURCE)
endef

$(eval $(generic-package))
