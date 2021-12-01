PKG=armutils

# use bash
SHELL=/usr/bin/bash

.PHONY: install release

all:
	echo "nothing to make"

install:
	for CMD in `ls bin`; do \
		install -Dm755 bin/$$CMD $(DESTDIR)/usr/bin/$$CMD; \
	done

# (1) adjust version in PKGBUILD, commit and push changes
# (2) create an annotated tag with name RELEASE
release:
	@if [ -z $(RELEASE) ]; then \
		echo "no new release submitted"; \
		exit 1; \
	fi	
	@VER_NEW=$(RELEASE); \
	VER_NEW=$${VER_NEW#v}; \
	VER_OLD=`sed -n "s/^pkgver=\(.*\)/\1/p" ./PKGBUILD`; \
	if ! [ `vercmp $${VER_OLD} $${VER_NEW}` -lt 0 ]; then \
		echo "new version is not greater than old version"; \
		exit 1; \
	fi; \
	sed -i -e "s/pkgver=.*/pkgver=$${VER_NEW#v}/" ./PKGBUILD
	@git commit -a -s -m "release $(RELEASE)"
	@git push
	@git tag -a $(RELEASE) -m "release $(RELEASE)"
	@git push origin $(RELEASE)		
