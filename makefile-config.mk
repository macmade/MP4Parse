# ------------------------------------------------------------------------------
# 
# Copyright (c) 2010, Jean-David Gadina <macmade@eosgarden.com>
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
#  -   Redistributions of source code must retain the above copyright notice,
#      this list of conditions and the following disclaimer.
#  -   Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#  -   Neither the name of 'Jean-David Gadina' nor the names of its
#      contributors may be used to endorse or promote products derived from
#      this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
# 
# ------------------------------------------------------------------------------
# 
# IMPORTANT NOTE:
# 
# This makefile is used for the configuration of the main makefile.
# It's not supposed to be called directly by the make command.
# 
# Please note that you need at least version 3.81 of GNU Make to use this file.
# Older versions are not supported and will never be.
# 
# You also need a copy of the GNU Libtool in order to handle the shared objects.
# GNU Libtool is sometimes called glibtool, or simply libtool.
# Others implementations of Libtool are not supported at the time.
# 
#-------------------------------------------------------------------------------

# $Id: makefile-config.mk 4 2011-01-05 07:42:35Z macmade@eosgarden.com $

#-------------------------------------------------------------------------------
# Project programming language
# 
# Actually, 'C', 'C++' and 'Objective-C' are supported
#-------------------------------------------------------------------------------

code                = C++

#-------------------------------------------------------------------------------
# Makefile language
#-------------------------------------------------------------------------------

lang                = en

#-------------------------------------------------------------------------------
# Final executables
#-------------------------------------------------------------------------------

EXEC                = mp4parse

#-------------------------------------------------------------------------------
# Dependancies for the executables (objects)
#-------------------------------------------------------------------------------

DEPS_mp4parse       = MP4.Atom \
                      MP4.BinaryStream \
                      MP4.ContainerAtom \
                      MP4.DataAtom \
                      MP4.File \
                      MP4.FullBox \
                      MP4.Parser \
                      MP4.UnknownAtom \
                      MP4.FREE \
                      MP4.FTYP \
                      MP4.MDHD \

#-------------------------------------------------------------------------------
# Dependancies for the executables (libraries)
#-------------------------------------------------------------------------------

DEPS_LIB_mp4parse   = 

#-------------------------------------------------------------------------------
# Dependancies for the executables (system libraries)
#-------------------------------------------------------------------------------

DEPS_SYSLIB_mp4parse = 

#-------------------------------------------------------------------------------
# Used frameworks (relevant only for Objective-C)
#-------------------------------------------------------------------------------

OBJC_FRAMEWORK      = Cocoa

#-------------------------------------------------------------------------------
# Paths (without the trailing slash)
#-------------------------------------------------------------------------------

DIR_BUILD           = ./build
DIR_BUILD_BIN       = $(DIR_BUILD)/bin
DIR_BUILD_OBJ       = $(DIR_BUILD)/obj
DIR_BUILD_LIB       = $(DIR_BUILD)/lib
DIR_BUILD_TMP       = $(DIR_BUILD)/tmp
DIR_SRC             = ./source
DIR_SRC_LIB         = $(DIR_SRC)/lib
DIR_SRC_INC         = $(DIR_SRC)/include
DIR_SRC_LIB_INC     = $(DIR_SRC_LIB)/include

#-------------------------------------------------------------------------------
# External tools
#-------------------------------------------------------------------------------

RM                  = rm
INSTALL             = install
SHELL               = /bin/sh

#-------------------------------------------------------------------------------
# Arguments for the external tools
#-------------------------------------------------------------------------------

ARGS_RM             = -rf
ARGS_INSTALL        = 

#-------------------------------------------------------------------------------
# Debug modes (only use for development purpose)
#-------------------------------------------------------------------------------

DEBUG_LIBTOOL       = 0
DEBUG_CC            = 0
DEBUG_RM            = 0
DEBUG_INSTALL       = 0

#-------------------------------------------------------------------------------
# Display options
#-------------------------------------------------------------------------------

DISPLAY_HEADER      = 1
DISPLAY_FOOTER      = 1

#-------------------------------------------------------------------------------
# Installation tools
#-------------------------------------------------------------------------------

INSTALL_PROGRAM     = $(INSTALL)
INSTALL_DATA        = $(INSTALL) -m 644

#-------------------------------------------------------------------------------
# Installation paths
#-------------------------------------------------------------------------------

prefix              = /usr/local
exec_prefix         = $(prefix)
bindir              = $(exec_prefix)/bin
sbindir             = $(exec_prefix)/sbin
libexecdir          = $(exec_prefix)/libexec
datarootdir         = $(prefix)/share
datadir             = $(datarootdir)
infodir             = $(datarootdir)/info
