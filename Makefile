# SPDX-FileCopyrightText: 2020 Michael Picht <mipi@fsfe.org>
#
# SPDX-License-Identifier: GPL-3.0-or-later

PKG=armutils

# use bash
SHELL=/bin/bash

.PHONY: shellcheck install

all:
	echo "nothing to make"

install:
	for CMD in `ls bin`; do \
		install -Dm755 bin/$$CMD $(DESTDIR)/usr/bin/$$CMD; \
	done
	install -Dm755 etc/makepkg_sudo $(DESTDIR)/etc/$(PKG)/makepkg_sudo
