# Makefile

PKGNAME = $(shell dpkg-parsechangelog -SSource)
VERSION = $(shell dpkg-parsechangelog -SVersion)

all:
	# Update program version from changelog
	if ! grep -q "^PROG_VERSION=$(VERSION)$$" src/dpkg; then \
	    sed '/^PROG_VERSION=/s/^.*$$/PROG_VERSION=$(VERSION)/' \
		< src/dpkg > src/dpkg.new; \
	    mv -f src/dpkg.new src/dpkg; \
	    chmod 755 src/dpkg; \
	fi

dist:
	git archive \
	    --prefix=$(PKGNAME)-$(VERSION)/ \
	    --output=$(PKGNAME)-$(VERSION).tar.xz \
	    $(VERSION)
