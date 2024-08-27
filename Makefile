CC=gcc
# Do not use Wall and Werror flags because students are not told about these in the lab
CFLAGS=-g

all: hello

hello:
	$(CC) $(CFLAGS) hello_world/hello.c -o hello_world/hello

clean:
	rm hello_world/hello
