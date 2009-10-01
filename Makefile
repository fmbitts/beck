CC=gcc -O3 -g

all:	beck

beck:	Makefile beck.c
	$(CC) beck.c -o beck

clean:
	rm -rfv \#*\# *~ *.aux *.log *.blg *.bbl *.log *.out *.toc

distclean:	clean
	rm -rfv beck

prepzip:	distclean
	rm -rfv CVS

