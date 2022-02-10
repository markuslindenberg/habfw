################################################################################
#
# restic
#
################################################################################

RESTIC_VERSION = 0.12.1
RESTIC_SITE = $(call github,restic,restic,v$(RESTIC_VERSION))
RESTIC_LICENSE = BSD
RESTIC_LICENSE_FILES = LICENSE
RESTIC_BUILD_TARGETS = cmd/restic

define RESTIC_POST_PATCH_VENDOR
	cd $(@D); $(HOST_GO_TARGET_ENV) GOPROXY=https://proxy.golang.org,direct $(GO_BIN) mod vendor -v
endef

RESTIC_POST_PATCH_HOOKS += RESTIC_POST_PATCH_VENDOR

define RESTIC_INSTALL_INIT_SYSTEMD
	#$(INSTALL) -D -m 644 -t $(TARGET_DIR)/usr/lib/systemd/system $(RESTIC_PKGDIR)/restic.service
	#$(INSTALL) -D -m 644 -t $(TARGET_DIR)/usr/lib/systemd/system $(RESTIC_PKGDIR)/restic.timer
endef

$(eval $(golang-package))
