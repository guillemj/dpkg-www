# Makefile

VERSION	= $(shell head -1 debian/changelog | sed 's/.*(//;s/).*//;s/-.*//')

all:
	if ! grep -q "^PROG_VERSION=$(VERSION)$$" src/dpkg; then \
	    sed '/^PROG_VERSION=/s/^.*$$/PROG_VERSION=$(VERSION)/' \
		< src/dpkg > src/dpkg.new; \
	    mv -f src/dpkg.new src/dpkg; \
	    chmod 755 src/dpkg; \
	fi

install:
	@ mkdir -p $(DESTDIR)/usr/lib/cgi-bin
	cp -p src/dpkg $(DESTDIR)/usr/lib/cgi-bin/

clean:
	rm -f `find . -name \*~`

distclean:	clean
