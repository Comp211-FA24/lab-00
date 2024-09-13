CC=gcc
# Do not use Wall and Werror flags because students are not told about these in the lab
CFLAGS=-g

.PHONY: all

all: hello

hello:
	$(CC) $(CFLAGS) hello_world/hello.c -o hello

clean:
	rm -f hello
