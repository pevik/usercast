#
# Copyright (c) 2013 Pavlo Lavrenenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

CFLAGS := $(shell pkg-config --cflags pidgin) -fPIC -O2 -Wall -pedantic -pipe
LDFLAGS := -shared
LIBS := $(shell pkg-config --libs pidgin)

TARGET := usercast.so
PREFIX := /usr/local
LIBDIR := $(PREFIX)/lib
USER_PLUGINS := $(HOME)/.purple/plugins

SOURCES := $(wildcard *.c)
OBJECTS := $(patsubst %.c, %.o, $(SOURCES))

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $(LIBS) $^ -o $@ $(LDFLAGS)

install: $(TARGET)
	mkdir -p $(DESTDIR)/$(LIBDIR)/pidgin
	cp $^ $(DESTDIR)/$(LIBDIR)/pidgin

user-install: $(TARGET)
	mkdir -p $(USER_PLUGINS)
	cp $< $(USER_PLUGINS)

clean:
	rm -f $(OBJECTS) $(TARGET)
