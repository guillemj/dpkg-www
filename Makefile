# Makefile

PKGNAME = $(shell dpkg-parsechangelog -SSource)
VERSION = $(shell dpkg-parsechangelog -SVersion)
RELTIME = $(shell dpkg-parsechangelog -STimestamp)
PODDATE = $(shell TZ=UTC0 LC_ALL=C date '+%F' --date="@$(RELTIME)")

POD2MAN = pod2man

MANS = src/dpkg-www.1 src/dpkg-www.8

all: src/dpkg $(MANS)

src/dpkg: src/dpkg-cgi
	# Update program version from changelog
	sed '/^PROG_VERSION=/s/^.*$$/PROG_VERSION=$(VERSION)/' <$< >$@
	chmod 755 $@

%: %.pod
	$(POD2MAN) \
	  --section=$(subst .,,$(suffix $@)) \
	  --name=$(basename $@) \
	  --center="Debian Project" \
	  --date="$(PODDATE)" \
	  --release="$(VERSION)" \
	    $< >$@

clean:
	$(RM) src/dpkg
	$(RM) $(MANS)

dist:
	git archive \
	    --prefix=$(PKGNAME)-$(VERSION)/ \
	    --output=$(PKGNAME)-$(VERSION).tar.xz \
	    $(VERSION)
