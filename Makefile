# SPDX-FileCopyrightText: 2020 Michael Picht <mipi@fsfe.org>
#
# SPDX-License-Identifier: GPL-3.0-or-later

PKG=armutils
CMDS=arm-nspawn mkarmroot makearmpkg

# use bash
SHELL=/bin/bash

.PHONY: shellcheck install

all:
	echo "nothing to make"

shellcheck:
	for CMD in $(CMDS); do \
		shellcheck "$$CMD"; \
	done	

install:
	for CMD in $(CMDS); do \
		install -Dm755 $$CMD $(DESTDIR)/usr/bin/$$CMD; \
	done
