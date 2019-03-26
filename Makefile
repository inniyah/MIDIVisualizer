#!/usr/bin/make -f

CC= gcc
CXX= g++
RM= rm -f

PKGCONFIG= pkg-config
PACKAGES= glfw3 gl gtk+-3.0

CFLAGS= -O2 -g -Wall -std=c++17 \
	-Isrc/helpers/ -Isrc/libs/ \
	-fstack-protector-strong \
	-Wall \
	-Wformat \
	-Werror=format-security \
	-Wdate-time \
	-D_FORTIFY_SOURCE=2 \
	$(shell $(PKGCONFIG) --cflags $(PACKAGES))

LDFLAGS= \
	-Wl,-z,defs,-z,relro,-z,now \
	-Wl,--as-needed \
	-Wl,--no-undefined

LIBS= \
	-lrt -lm -pthread -ldl \
	$(shell $(PKGCONFIG) --libs $(PACKAGES))

CPP_SRCS= \
	src/main.cpp \
	src/midi/MIDIFile.cpp \
	src/midi/MIDITrack.cpp \
	src/midi/MIDIUtils.cpp \
	src/rendering/Background.cpp \
	src/rendering/Framebuffer.cpp \
	src/rendering/MIDIScene.cpp \
	src/rendering/Renderer.cpp \
	src/rendering/ScreenQuad.cpp \
	src/rendering/State.cpp \
	src/rendering/camera/Camera.cpp \
	src/rendering/camera/Keyboard.cpp \
	src/helpers/MeshUtilities.cpp \
	src/helpers/ProgramUtilities.cpp \
	src/helpers/ResourcesManager.cpp \
	src/resources/flash_image.cpp \
	src/resources/font_image.cpp \
	src/resources/particles_image.cpp \
	src/resources/shaders.cpp \
	src/libs/gl3w/gl3w.cpp \
	src/libs/imgui/imgui.cpp \
	src/libs/imgui/imgui_demo.cpp \
	src/libs/imgui/imgui_draw.cpp \
	src/libs/imgui/imgui_impl_glfw_gl3.cpp

C_SRCS= \
	src/libs/nfd/nfd_common.c \
	src/libs/nfd/nfd_gtk.c

OBJS= $(subst .cpp,.o,$(CPP_SRCS)) $(subst .c,.o,$(C_SRCS))

BINARY= midiviz

all: $(BINARY)

$(BINARY): $(OBJS) packager
	./packager
	$(CXX) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)

packager: src/packager.o src/libs/lodepng/lodepng.o
	$(CXX) $(LDFLAGS) -o $@ $+

%.o: %.cpp
	$(CXX) -o $@ -c $< $(CFLAGS)

%.o: %.cc
	$(CXX) -o $@ -c $< $(CFLAGS)

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

depend: .depend

.depend: $(CPP_SRCS) $(C_SRCS)
	$(RM) ./.depend
	$(CXX) $(CFLAGS) -MM $^>>./.depend;

clean:
	$(RM) $(OBJS) $(shell rm -fv $$(find . -name *.o)) src/*.o $(BINARY) packager

distclean cleanall: clean
	$(RM) *~ .depend core *.out *.bak

include .depend

.PHONY: all depend clean distclean cleanall

