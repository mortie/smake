DESTDIR ?=
PREFIX ?= /usr/local

.PHONY: check
check:
	shellcheck smake

.PHONY: install
install: smake
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 0755 $^ $(DESTDIR)$(PREFIX)/bin

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/smake

.PHONY: readme-toc
readme-toc:
	markdown-toc -i README.md
