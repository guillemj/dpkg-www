# Makefile

PKGNAME = $(shell dpkg-parsechangelog -SSource)
VERSION = $(shell dpkg-parsechangelog -SVersion)

all: src/dpkg

src/dpkg: src/dpkg-cgi
	# Update program version from changelog
	sed '/^PROG_VERSION=/s/^.*$$/PROG_VERSION=$(VERSION)/' <$< >$@
	chmod 755 $@

clean:
	$(RM) src/dpkg

dist:
	git archive \
	    --prefix=$(PKGNAME)-$(VERSION)/ \
	    --output=$(PKGNAME)-$(VERSION).tar.xz \
	    $(VERSION)
