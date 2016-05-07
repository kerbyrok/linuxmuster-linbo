################################################################################
#
# grub2efi32
#
################################################################################

GRUB2EFI64_VERSION = 2.02-beta3
GRUB2EFI64_SITE = git://git.sv.gnu.org/grub.git
GRUB2EFI64_LICENSE = GPLv3
GRUB2EFI64_LICENSE_FILES = COPYING

define GRUB2EFI64_AUTOGEN
	cd $(@D) && ./autogen.sh
endef
GRUB2EFI64_PRE_CONFIGURE_HOOKS += GRUB2EFI64_AUTOGEN

GRUB2EFI64_CONF_ENV = \
	CPP="$(TARGET_CC) -E"
GRUB2EFI64_CONF_OPTS = --disable-nls --disable-efiemu --disable-mm-debug --disable-cache-stats --disable-boot-time --disable-grub-mkfont --disable-grub-themes --disable-grub-mount --enable-device-mapper --disable-liblzma --disable-libzfs --with-platform=efi  --target=x86_64

define GRUB2EFI64_CLEANUP
	rm -fv $(TARGET_DIR)/usr/lib/grub/x86_64-efi/*.image
	rm -fv $(TARGET_DIR)/usr/lib/grub/x86_64-efi/*.module
	rm -fv $(TARGET_DIR)/usr/lib/grub/x86_64-efi/kernel.exec
	rm -fv $(TARGET_DIR)/usr/lib/grub/x86_64-efi/gdb_grub
	rm -fv $(TARGET_DIR)/usr/lib/grub/x86_64-efi/gmodule.pl
endef
GRUB2EFI64_POST_INSTALL_TARGET_HOOKS += GRUB2EFI64_CLEANUP

$(eval $(autotools-package))
