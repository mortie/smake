DESTDIR ?=
PREFIX ?= /usr/local

.PHONY: check
check:
	shellcheck smake

.PHONY: install
install: smake
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f $^ $(DESTDIR)$(PREFIX)/bin

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/smake

.PHONY: readme-toc
readme-toc:
	markdown-toc -i README.md
