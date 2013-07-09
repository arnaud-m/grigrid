SHELL = /bin/sh
name=grigrid
version=0.2
bins=$(wildcard bin/*)


# build directories.
testdir=test
mandir=man
docdir=doc

#looking for help2man
help2man=$(shell type -t help2man > /dev/null 2>&1 && echo help2man)
ifdef $(help2man)
man1=$(bins:bin/%=man/%.1)
man1gz=$(man1:%=%.gz)
manual=$(docdir)/$(name)-manpages.pdf
endif

# install directories
# Common prefix
prefix =~#/usr/local
bintdir=$(prefix)/bin
mantdir = $(prefix)/man/man1

manexecs=$(bins:bin/%=$(mantdir)/%.1.gz)
binexecs=$(bins:bin/%=$(bintdir)/%)

all : dist ;

dist-clean : ;
	rm -fr $(mandir) $(docdir) 

dist-dirs : dist-clean;
	mkdir $(mandir) $(docdir)

man/%.1 : bin/% 
	help2man -v -v -h -h --no-discard-stderr --no-info $< -o $@

man/%.1.gz : man/%.1
	gzip $<

$(manual) : $(man1);
	groff -Tps -mandoc $^ | ps2pdf  - $@ ;\

dist: dist-dirs $(manual) $(man1gz);

dist-archive : dist ;	
	tar -czf $(name)-$(version).tar.gz  .

install-dirs: ;
	mkdir -p $(bintdir) $(mantdir);

install: dist install-dirs;
ifdef $(man1gz)
		cp $(man1gz) $(mantdir);	
endif	
	cp $(bins) $(bintdir)

uninstall: ;
	rm -f $(binexecs) $(manexecs);

reinstall : dist-clean dist install;

test : test-clean; 
	cd $(testdir); ./test-grigrid.sh;

#keep on a single line to preserve the cd command	
test-clean : ;
	cd $(testdir); rm -f *.tar.gz *.log ; rm -fr results;


clean: dist-clean test-clean ;

