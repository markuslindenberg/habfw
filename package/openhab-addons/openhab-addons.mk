################################################################################
#
# openhab-addons
#
################################################################################

OPENHAB_ADDONS_VERSION = 3.0.1
OPENHAB_ADDONS_SOURCE = openhab-addons-$(OPENHAB_ADDONS_VERSION).kar
OPENHAB_ADDONS_SITE = https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab-addons/$(OPENHAB_ADDONS_VERSION)
OPENHAB_ADDONS_LICENSE = EPL-2.0

define OPENHAB_ADDONS_EXTRACT_CMDS
endef

define OPENHAB_ADDONS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(OPENHAB_ADDONS_DL_DIR)/$(OPENHAB_ADDONS_SOURCE) $(TARGET_DIR)/opt/openhab/addons/$(OPENHAB_ADDONS_SOURCE)
endef

$(eval $(generic-package))
