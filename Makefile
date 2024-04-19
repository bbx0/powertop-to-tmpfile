
.SUFFIXES:
SHELL		= /bin/sh
HELP2MAN	:= help2man
PREFIX		:= /usr/local

# Common prefix for installation directories.
prefix		:= ${PREFIX}
exec_prefix	:= $(prefix)
bindir		:= $(exec_prefix)/bin
datarootdir	:= $(prefix)/share
mandir		:= $(datarootdir)/man
man1dir		:= $(mandir)/man1

# Generate manpage from `--help` command
powertop-to-tmpfile.1: powertop-to-tmpfile
	$(HELP2MAN) --no-info --help-option='--help man' --output=$@ $(abspath $<)

.PHONY: install
install: powertop-to-tmpfile powertop-to-tmpfile.1
	install -Dm755 -t $(DESTDIR)$(bindir) powertop-to-tmpfile
	install -Dm644 -t $(DESTDIR)$(man1dir) powertop-to-tmpfile.1

.PHONY: uninstall
uninstall:
	-rm $(DESTDIR)$(bindir)/powertop-to-tmpfile
	-rm $(DESTDIR)$(man1dir)/powertop-to-tmpfile.1

.PHONY: clean
clean:
	-rm powertop-to-tmpfile.1