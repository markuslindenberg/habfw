################################################################################
#
# zulu
#
################################################################################

ZULU_VERSION = 11.52.13
ZULU_SOURCE = zulu$(ZULU_VERSION)-ca-jdk11.0.13-linux_aarch32hf.tar.gz
ZULU_SITE = https://cdn.azul.com/zulu-embedded/bin
ZULU_LICENSE = GPL2
ZULU_LICENSE_FILES = LICENSE
ZULU_INSTALL_BASE = /opt/jvm

define ZULU_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)$(ZULU_INSTALL_BASE)
	cp -dpfr $(@D)/* $(TARGET_DIR)$(ZULU_INSTALL_BASE)/
	cd $(TARGET_DIR)/usr/bin && ln -snf ../..$(ZULU_INSTALL_BASE)/bin/* .
endef

$(eval $(generic-package))
