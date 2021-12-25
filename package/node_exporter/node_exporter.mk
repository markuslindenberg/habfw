################################################################################
#
# node_exporter
#
################################################################################

NODE_EXPORTER_VERSION = 1.3.1
NODE_EXPORTER_SITE = $(call github,prometheus,node_exporter,v$(NODE_EXPORTER_VERSION))
NODE_EXPORTER_LICENSE = Apache-2.0
NODE_EXPORTER_LICENSE_FILES = LICENSE

define NODE_EXPORTER_POST_PATCH_VENDOR
	cd $(@D); $(HOST_GO_TARGET_ENV) GOPROXY=https://proxy.golang.org,direct $(GO_BIN) mod vendor -v
endef

NODE_EXPORTER_POST_PATCH_HOOKS += NODE_EXPORTER_POST_PATCH_VENDOR

define NODE_EXPORTER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 -t $(TARGET_DIR)/usr/lib/systemd/system $(NODE_EXPORTER_PKGDIR)/node_exporter.service
endef

$(eval $(golang-package))
