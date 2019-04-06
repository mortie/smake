DESTDIR ?=
PREFIX ?= /usr/local

.PHONY: check
check:
	shellcheck smake
	./smake -C examples/simple clean
	./smake -C examples/simple
	./smake -C examples/complex clean
	./smake -C examples/complex

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
