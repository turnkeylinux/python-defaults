#!/usr/bin/make -f
INSTALL ?= install
PREFIX ?= /usr

clean:
	make -C tests clean
	find . -name '*\.py[co]' -delete
	rm -f .coverage

install-dev:
	$(INSTALL) -m 755 -d $(DESTDIR)$(PREFIX)/share/python/runtime.d \
		$(DESTDIR)$(PREFIX)/share/debhelper/autoscripts/ $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) -m 644 runtime.d/* $(DESTDIR)$(PREFIX)/share/python/runtime.d/
	$(INSTALL) -m 644 autoscripts/* $(DESTDIR)$(PREFIX)/share/debhelper/autoscripts/
	#$(INSTALL) -m 755 dh_python $(DESTDIR)$(PREFIX)/bin/
	$(INSTALL) -m 755 dh_python $(DESTDIR)$(PREFIX)/bin/dh_python2

install-runtime:
	$(INSTALL) -m 755 -d $(DESTDIR)$(PREFIX)/share/python/debpython $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) -m 644 debpython/* $(DESTDIR)$(PREFIX)/share/python/debpython/
	$(INSTALL) -m 755 pycompile $(DESTDIR)$(PREFIX)/bin/
	$(INSTALL) -m 755 pyclean $(DESTDIR)$(PREFIX)/bin/

install: install-dev install-runtime

nose:
	nosetests --with-doctest --with-coverage

tests: nose
	make -C tests

test%:
	make -C tests $@

.PHONY: clean tests test%