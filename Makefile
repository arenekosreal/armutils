PKG=armutils

# use bash
SHELL=/bin/bash

.PHONY: install

all:
	echo "nothing to make"

install:
	for CMD in `ls bin`; do \
		install -Dm755 bin/$$CMD $(DESTDIR)/usr/bin/$$CMD; \
	done
	install -Dm755 etc/makepkg_sudo $(DESTDIR)/etc/$(PKG)/makepkg_sudo
