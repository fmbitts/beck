CC=gcc
FLAGS=-O4
LIBS=-lm

all:	beck

beck:	Makefile beck.c
	$(CC) $(FLAGS) beck.c $(LIBS) -o beck

clean:
	rm -rfv \#*\# *~ *.aux *.log *.blg *.bbl *.log *.out *.toc

distclean:	clean
	rm -rfv beck

prepzip:	distclean
	rm -rfv CVS

