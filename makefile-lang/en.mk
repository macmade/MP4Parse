# ------------------------------------------------------------------------------
# 
# Copyright (c) 2010, Jean-David Gadina - www.xs-labs.com
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
# This makefile contains the language labels for the main makefile.
# It's not supposed to be called directly by the make command.
# 
# Words in uppercase beginning end ending with a '_' are placeholders for
# dynamic variables and will be substituded during the make process. Do not
# translated them. Also remember that you have to escape special characters
# with a backslash.
# 
# Please note that you need at least version 3.81 of GNU Make to use this file.
# Older versions are not supported and will never be.
# 
# ------------------------------------------------------------------------------

# $Id$

# Flag to let the makefile knows that the language labels were included
LANG_HASLABELS           := 1

# Language labels
LANG_MAKESTART           := Beginning make script - GNU Make _VERSION_
LANG_MAKEEND             := End of the make script
LANG_DONE                := Done
LANG_LIB_START           := Finding and building the libraries
LANG_LIB_END             := All libraries were processed
LANG_SO_START            := Finding and building the shared objects
LANG_SO_END              := All shared objects were processed
LANG_EXEC_START          := Finding and building the executables
LANG_EXEC_END            := All executables were processed
LANG_CLEAN_START         := Removing all the build files in _DIR_BUILD_
LANG_NOSCRIPT_UNINSTALL  := Sorry, but there\'s actually no uninstall script
LANG_NOSCRIPT_TEST       := Sorry, but there\'s actually no test script
LANG_NOSCRIPT_INFOS      := You should find your build files and binaries in _DIR_BUILD_
LANG_O_BUILD             := Building the object file for _CFILE_ in _DIR_BUILD_
LANG_LO_BUILD            := Building the library object file for _CFILE_ in _DIR_BUILD_
LANG_LA_BUILD            := Building the library archive file for _TNAME_ in _DIR_BUILD_
LANG_DEPS_FIND           := Finding dependancies for _TFILE_
LANG_DEPS_LIB_FIND       := Finding local library dependancies for _TFILE_
LANG_DEPS_SYSLIB_FIND    := Finding system dependancies for _TFILE_
LANG_DEPS_NODEPS         := _TFILE_ does not depend on shared objects
LANG_OUT_BUILD           := Building the output file for _CFILE_ in _DIR_BUILD_
LANG_EXEC_BUILD_HASDEPS  := Building the executable _TFILE_ in _DIR_BUILD_ by linking _OFILE_ with its dependancies: _DEPS_
LANG_EXEC_BUILD_NODEPS   := Building the executable _TFILE_ for _CFILE_ in _DIR_BUILD_
LANG_INSTALL_BIN         := Installing executables into _PREFIX_
