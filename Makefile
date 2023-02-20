#For large/er C projects.
CC = gcc
CFLAGS = -Wall -Wextra -std=c11
DEBUG_FLAGS = -g -Og
RELEASE_FLAGS = -O2
LDFLAGS = -lm -lpthread
INCLUDE_PATHS = -I./include
SOURCES = main.c foo.c bar.c
OBJECTS = $(SOURCES:.c=.o)
DEPS = $(OBJECTS:.o=.d)
EXECUTABLE = myprogram
all: debug
debug: CFLAGS += $(DEBUG_FLAGS)
debug: $(EXECUTABLE)
release: CFLAGS += $(RELEASE_FLAGS)
release: $(EXECUTABLE)
$(EXECUTABLE): $(OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(INCLUDE_PATHS) $(OBJECTS) -o $(EXECUTABLE)
%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDE_PATHS) -c $< -o $@
	$(CC) $(CFLAGS) $(INCLUDE_PATHS) -MM $< -o $(@:.o=.d)
clean:
	rm -f $(EXECUTABLE) $(OBJECTS) $(DEPS)
