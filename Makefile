# Makefile

VERSION	= $(shell head -1 debian/changelog | sed 's/.*(//;s/).*//;s/-.*//')
PKGFILE = $(shell cd ..; find . -name dpkg-www_$(VERSION)_*.deb | sed 's|./||')
CHANGES = $(shell cd ..; find . -name dpkg-www_$(VERSION)_*.changes)

all:
	# Update program version from changelog
	if ! grep -q "^PROG_VERSION=$(VERSION)$$" src/dpkg; then \
	    sed '/^PROG_VERSION=/s/^.*$$/PROG_VERSION=$(VERSION)/' \
		< src/dpkg > src/dpkg.new; \
	    mv -f src/dpkg.new src/dpkg; \
	    chmod 755 src/dpkg; \
	fi

install:
	@ mkdir -p $(DESTDIR)/usr/lib/cgi-bin
	@ mkdir -p $(DESTDIR)/usr/bin
	@ mkdir -p $(DESTDIR)/usr/share/man/man1
	cp -p src/dpkg $(DESTDIR)/usr/lib/cgi-bin/
	cp -p src/dpkg-www $(DESTDIR)/usr/bin/
	cp -p src/dpkg-www-installer $(DESTDIR)/usr/sbin/
	cp -p src/dpkg-www.xpm $(DESTDIR)/usr/share/pixmaps/
	cp -p src/dpkg-www.1 $(DESTDIR)/usr/share/man/man1/
	cp -p src/dpkg-www.8 $(DESTDIR)/usr/share/man/man8/
	cp -p src/dpkg-www.conf $(DESTDIR)/etc/

clean:
	rm -f `find . -name \*~`

distclean:	clean

diff:
	@diff -u src/dpkg /usr/lib/cgi-bin/dpkg

deb:
	dpkg-buildpackage -rfakeroot -us -uc

package:
	dpkg-buildpackage -rfakeroot

lintian:
	lintian -i ../$(PKGFILE)

upload:
	cd .. && dupload $(CHANGES)

# end of file
