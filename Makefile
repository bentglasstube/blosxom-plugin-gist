.PHONY: all test clean

all: gist

gist: lib/gist.pm
	cp lib/gist.pm gist

test: 
	prove -l

clean:
	rm gist
