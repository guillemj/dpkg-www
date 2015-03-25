# Makefile

PKGNAME = $(shell head -1 debian/changelog | sed 's/ .*//')
VERSION	= $(shell head -1 debian/changelog | sed 's/.*(//;s/).*//;s/-.*//')
PKGFILE	= $(PKGNAME)_$(VERSION)_all.deb
CHANGES	= $(PKGNAME)_$(VERSION)_$(shell dpkg --print-architecture).changes

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

package:
	dpkg-buildpackage -rfakeroot

dist:
	dpkg-buildpackage -rfakeroot

deb:
	dpkg-buildpackage -rfakeroot -us -uc

debclean:
	fakeroot ./debian/rules clean

debinst:
	cd .. && sudo dpkg -i $(PKGFILE)

lintian:
	cd .. && lintian -i $(PKGFILE)

upload:
	cd .. && grep -q 'PGP SIGNED MESSAGE' $(CHANGES) && dupload $(CHANGES)

# end of file
