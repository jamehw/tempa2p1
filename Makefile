###############################################################################
# COSC1076 - Advanced Programming Techniques                                  #
# Assessed lab 1 - debugging                                                  #
# Created by Paul Miller                                                      #
#                                                                             #
# Makefile for the assessed lab. Simply type 'make' (no quotes) to compile    #
# this project.                                                               #
###############################################################################

# The head files for this project
HEADERS=main.h fsupport.h stop.h
# The object files that need to be built for this project
OBJECTS=fsupport.o main.o stop.o
# The compiler we are using 
CC=gcc
# The compiler flags
CFLAGS=-ansi -Wall -pedantic
# The linker flags
LFLAGS=

# The default target is always first in the file - it just calls the 'poker' 
# target
all:stopper

# This target calls the linker. It links together all the object files that 
# have been compiled along with any libraries that you have included.
stopper: $(OBJECTS)
	$(CC) $(LFLAGS) $(OBJECTS) -o stopper

# compiles each .c file into a .o file
%.o:%.c $(HEADERS)
	$(CC) $(CFLAGS) -c $<

# the debug target - if you type make debug, you will recompile your program,
# building in the debugging symbols for use with gdb and valgrind
debug:CFLAGS+=-g
debug:clean stopper

# the sanitize target - this uses libasan to verify the memory access use of 
# your program

sanitize:CFLAGS+=-fsanitize=address
sanitize:LFLAGS+=-fsanitize=address
sanitize:debug

# the clean target - deletes the object files and the executable
.PHONY:clean
clean:
	rm -f *.o stopper
