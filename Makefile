SHELL = /bin/sh
name=grigrid
version=0.1
BIN=$(wildcard bin/*)
MAN=$(BIN:bin/%=man/%.1)


# build directories.
testdir=test
mandir=man
docdir=doc
manpages=$(docdir)/$(name)-manpages.pdf

# install directories
# Common prefix
prefix =~#/usr/local
bindir=$(prefix)/bin
# Where to put the directories used by the compiler.
libdir =$(prefix)/.$(name)
# Where to put the Info files.
man1dir = $(prefix)/man/man1
manexecs=$(BIN:bin/%=$(man1dir)/%.1.gz)
binexecs=$(BIN:bin/%=$(bindir)/%)

all : dist ;

initdirs : dist-clean;
	mkdir $(mandir) $(docdir)

man/%.1 : bin/% 
	help2man --no-info $< -o $@

$(manpages) : $(MAN) ;
	groff -Tps -mandoc $^ | ps2pdf  - $@

dist: initdirs $(manpages);

dist-archive : dist ;	
	tar -czf $(name)-$(version).tar.gz  octave bin awk $(docdir)  Makefile README COPYING
	tar -czf $(name)-$(version)-test.tar.gz  test/* 	

installdirs: ;
	mkdir -p $(bindir) $(man1dir) $(libdir);

install: installdirs ;
	gzip $(MAN);
	cp $(mandir)/* $(man1dir) 
	cp $(BIN) $(bindir)
	cp awk/* octave/* $(libdir)	 	

uninstall: ;
	rm -f $(binexecs) $(manexecs);
	rm -fr $(libdir) 

reinstall : dist-clean dist install;

test : test-clean; 
	cd $(testdir); ./test-grid4j.sh;

test-clean : ;
#keep on a single line to preserve the cd command
	cd $(testdir); rm -f *.tar.gz *.log *.res *.dat *.gpl; rm -fr F__TB B__TB;

dist-clean : ;
	rm -fr $(mandir) $(docdir) 

clean: dist-clean test-clean ;

