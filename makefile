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
# You are not supposed to edit this file.
# For the configuration, please see the configuration.mk file.
# Language labels are also in separate files.
# 
# Please note that you need at least version 3.81 of GNU Make to use this file.
# Older versions are not supported and will never be.
# 
#-------------------------------------------------------------------------------

# $Id$

#-------------------------------------------------------------------------------
# Includes
#-------------------------------------------------------------------------------

# Includes the configuration file
include makefile-config.mk

# Includes the language file
-include makefile-lang/$(lang).mk

# Includes the language file
-include makefile-code/$(code).mk

# Checks if the language labels are defined
ifndef LANG_HASLABELS

# Includes the default language file
-include makefile-lang/en.mk

endif

#-------------------------------------------------------------------------------
# File suffixes
#-------------------------------------------------------------------------------

# Clears any existing suffix
.SUFFIXES:

# Adds the suffixes used in this file
.SUFFIXES: $(EXT_CODE) $(EXT_HEADERS) $(EXT_LIB_OBJECT) $(EXT_LIB_ARCHIVE) $(EXT_OBJECT)

#-------------------------------------------------------------------------------
# Search paths
#-------------------------------------------------------------------------------

# Clear any existing search path
VPATH =
vpath

# Define the search paths for source files
vpath %$(EXT_CODE) $(DIR_SRC)
vpath %$(EXT_CODE) $(DIR_SRC_LIB)

# Define the search paths for header files
vpath %$(EXT_HEADERS) $(DIR_SRC_INC)
vpath %$(EXT_HEADERS) $(DIR_SRC_LIB_INC)

# Define the search paths for library object files
vpath %$(EXT_LIB_OBJECT) $(DIR_BUILD_LIB)

# Define the search paths for library archive files
vpath %$(EXT_LIB_ARCHIVE) $(DIR_BUILD_LIB)

# Define the search paths for source output files
vpath %$(EXT_OBJECT) $(DIR_BUILD_OBJ)

#-------------------------------------------------------------------------------
# Macros
#-------------------------------------------------------------------------------

# Adds a trailing slash on each path variable from the configuration
_DIR_BUILD        = $(DIR_BUILD)/
_DIR_BUILD_BIN    = $(DIR_BUILD_BIN)/
_DIR_BUILD_OBJ    = $(DIR_BUILD_OBJ)/
_DIR_BUILD_LIB    = $(DIR_BUILD_LIB)/
_DIR_BUILD_TMP    = $(DIR_BUILD_TMP)/
_DIR_SRC          = $(DIR_SRC)/
_DIR_SRC_LIB      = $(DIR_SRC_LIB)/
_DIR_SRC_INC      = $(DIR_SRC_INC)/
_DIR_SRC_LIB_INC  = $(DIR_SRC_LIB_INC)/

# Gets every code file in the library directory
_FILES_LIB        = $(foreach dir,$(_DIR_SRC_LIB),$(wildcard $(_DIR_SRC_LIB)*$(EXT_CODE)))

# Gets only the file name of the library files
_FILES_LIB_REL    = $(notdir $(_FILES_LIB))

# Replace the code extension by the archive one
_FILES_LIB_LA     = $(subst $(EXT_CODE),$(EXT_LIB_ARCHIVE),$(_FILES_LIB_REL))

# Prefix all library files with the build directory
_FILES_LIB_BUILD  = $(addprefix $(_DIR_BUILD_LIB),$(_FILES_LIB_LA))

# Gets every code file in the source directory
_FILES_SRC        = $(foreach dir,$(_DIR_SRC),$(wildcard $(_DIR_SRC)*$(EXT_CODE)))

# Gets only the file name of the source files
_FILES_SRC_REL    = $(notdir $(_FILES_SRC))

# Replaces the code extension by the object extension
_FILES_SRC_O      = $(subst $(EXT_CODE),$(EXT_OBJECT),$(_FILES_SRC_REL))

# Prefix all code files with the object directory
_FILES_SRC_BUILD  = $(addprefix $(_DIR_BUILD_OBJ),$(_FILES_SRC_O))

# Prefix all executables with the build directory
_FILES_EXEC_BUILD = $(addprefix $(_DIR_BUILD_BIN),$(EXEC))

# Stem symbol (defined to avoid problems with the second expansion)
_STEM             = %

# Adds the include directory to the search paths
_ARGS_CC          = -I $(DIR_SRC_INC) -I $(DIR_SRC_LIB_INC) $(ARGS_CC)

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean install test _start _end _so_start _so_end _exec_start _exec_end

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Checks if the language labels are defined
ifdef LANG_HASLABELS

ifdef CODE_HASOPTIONS

# Builds the complete program
# 
# 1) Builds each shared object
# 2) Builds each exectuable
# 
all: _start _lib_start $(_FILES_LIB_BUILD) _lib_end _so_start $(_FILES_SRC_BUILD) _so_end _exec_start $(_FILES_EXEC_BUILD) _exec_end _end

else

# No language labels - Error
all:
	@echo 
	@echo Sorry, but the code specific options were not found
	@echo Requested code: $(code) \(file should be makefile-code/$(code).mk\)
	@echo 

endif

else

# No language labels - Error
all:
	@echo 
	@echo Sorry, but the language labels were not found
	@echo Requested language: $(lang) \(file should be makefile-lang/$(lang).mk\)
	@echo 
	
endif

# Removes all build files
clean:
	@echo
	@echo --- $(subst _DIR_BUILD_,$(_DIR_BUILD_BIN),$(LANG_CLEAN_START))
	$(if $(filter 1,$(DEBUG_RM)),@echo $(RM) $(ARGS_RM) $(_DIR_BUILD_BIN)*)
	@$(RM) $(ARGS_RM) $(_DIR_BUILD_BIN)*
	@echo --- $(LANG_DONE)
	@echo
	@echo --- $(subst _DIR_BUILD_,$(_DIR_BUILD_LIB),$(LANG_CLEAN_START))
	$(if $(filter 1,$(DEBUG_RM)),@echo $(RM) $(ARGS_RM) $(_DIR_BUILD_LIB)*)
	@$(RM) $(ARGS_RM) $(_DIR_BUILD_LIB)*
	@echo --- $(LANG_DONE)
	@echo
	@echo --- $(subst _DIR_BUILD_,$(_DIR_BUILD_OBJ),$(LANG_CLEAN_START))
	$(if $(filter 1,$(DEBUG_RM)),@echo $(RM) $(ARGS_RM) $(_DIR_BUILD_OBJ)*)
	@$(RM) $(ARGS_RM) $(_DIR_BUILD_OBJ)*
	@echo --- $(LANG_DONE)
	@echo
	@echo --- $(subst _DIR_BUILD_,$(_DIR_BUILD_TMP),$(LANG_CLEAN_START))
	$(if $(filter 1,$(DEBUG_RM)),@echo $(RM) $(ARGS_RM) $(_DIR_BUILD_TMP)*)
	@$(RM) $(ARGS_RM) $(_DIR_BUILD_TMP)*
	@echo --- $(LANG_DONE)
	@echo

# Install the executables
install: all
	@echo
	@echo --- $(subst _PREFIX_,$(prefix),$(LANG_INSTALL_BIN)/bin)
	$(if $(filter 1,$(DEBUG_INSTALL)),@echo $(INSTALL) -d $(ARGS_INSTALL) $(prefix)/bin)
	@$(INSTALL) -d $(ARGS_INSTALL) $(prefix)/bin
	$(if $(filter 1,$(DEBUG_INSTALL)),@echo $(INSTALL_PROGRAM) $(ARGS_INSTALL) $(_DIR_BUILD_BIN)* $(prefix)/bin)
	@$(INSTALL_PROGRAM) $(ARGS_INSTALL) $(_DIR_BUILD_BIN)* $(prefix)/bin
	@echo --- $(LANG_DONE)
	@echo

# Uninstall the executables
uninstall:
	@echo
	@echo --- $(LANG_NOSCRIPT_UNINSTALL)
	@echo --- $(subst _DIR_BUILD_,$(_DIR_BUILD),$(LANG_NOSCRIPT_INFOS))
	@echo

# Test the executables
test:
	@echo
	@echo --- $(LANG_NOSCRIPT_TEST)
	@echo --- $(subst _DIR_BUILD_,$(_DIR_BUILD),$(LANG_NOSCRIPT_INFOS))
	@echo

# Start message
_start:
ifeq ($(DISPLAY_HEADER),1)
	@echo
	@echo \#--------------------------------------------------
	@echo \# $(subst _VERSION_,$(MAKE_VERSION),$(LANG_MAKESTART))
	@echo \#--------------------------------------------------
endif

# Success message
_end:
ifeq ($(DISPLAY_FOOTER),1)
	@echo
	@echo \#--------------------------------------------------
	@echo \# $(LANG_MAKEEND)
	@echo \#--------------------------------------------------
	@echo
endif

# Libraries - Start
_lib_start:
	@echo 
	@echo --- $(LANG_LIB_START)

# Libraries - End
_lib_end:
	@echo 
	@echo --- $(LANG_DONE) - $(LANG_LIB_END)

# Shared objects - Start
_so_start:
	@echo 
	@echo --- $(LANG_SO_START)

# Shared objects - End
_so_end:
	@echo 
	@echo --- $(LANG_DONE) - $(LANG_SO_END)

# Shared objects - Start
_exec_start:
	@echo 
	@echo --- $(LANG_EXEC_START)

# Shared objects - End
_exec_end:
	@echo 
	@echo --- $(LANG_DONE) - $(LANG_EXEC_END)

#-------------------------------------------------------------------------------
# Other targets
#-------------------------------------------------------------------------------

# Builds the libraries
# 
# 1) Compile each code file from library directory as an object file in the build directory
# 2) Creates a library object file from the previously generated object file
# 3) Creates a library archive file from the previously generated library object file
# 
$(_DIR_BUILD_LIB)%$(EXT_LIB_ARCHIVE): %$(EXT_CODE) %$(EXT_HEADERS)
	@echo
	@echo ------ $(subst _CFILE_,$<,$(subst _DIR_BUILD_,$(_DIR_BUILD_LIB),$(LANG_LO_BUILD)))
	$(if $(filter 1,$(DEBUG_CC)), @echo $(CC) -o $(subst $(EXT_LIB_ARCHIVE),$(EXT_OBJECT),$@) -c $< $(_ARGS_CC) $(CFLAGS))
	@$(CC) -o $(subst $(EXT_LIB_ARCHIVE),$(EXT_OBJECT),$@) -c $< $(_ARGS_CC) $(CFLAGS)
	@echo ------ $(LANG_DONE)
	@echo
	@echo ------ $(subst _TNAME_,$(addprefix $(_DIR_BUILD_LIB),$(subst $(EXT_LIB_ARCHIVE),$(EXT_OBJECT),$(@F))),$(subst _DIR_BUILD_,$(_DIR_BUILD_LIB),$(LANG_LA_BUILD)))
	$(if $(filter 1,$(DEBUG_LIBTOOL)), @echo $(LIBTOOL) $(_ARGS_LIBTOOL) -static -o $@ $(subst $(EXT_LIB_ARCHIVE),$(EXT_OBJECT),$@))
	@$(LIBTOOL) $(_ARGS_LIBTOOL) -static -o $@ $(subst $(EXT_LIB_ARCHIVE),$(EXT_OBJECT),$@)
	@echo ------ $(LANG_DONE)

# Builds the shared objects (with header file)
# 
# 1) Compile each code file from library directory as an object file in the build directory
# 
$(_DIR_BUILD_OBJ)%$(EXT_OBJECT): %$(EXT_CODE) %$(EXT_HEADERS)
	@echo
	@echo ------ $(subst _CFILE_,$<,$(subst _DIR_BUILD_,$(_DIR_BUILD_OBJ),$(LANG_O_BUILD)))
	$(if $(filter 1,$(DEBUG_CC)), @echo $(CC) $(_ARGS_CC) -o $(_DIR_BUILD_OBJ)$(@F) -c $< $(CFLAGS))
	@$(CC) $(_ARGS_CC) -o $(_DIR_BUILD_OBJ)$(@F) -c $< $(CFLAGS)
	@echo ------ $(LANG_DONE)

# Builds the shared objects (without header file)
# 
# 1) Compile each code file from library directory as an object file in the build directory
# 
$(_DIR_BUILD_OBJ)%$(EXT_OBJECT): %$(EXT_CODE)
	@echo
	@echo ------ $(subst _CFILE_,$<,$(subst _DIR_BUILD_,$(_DIR_BUILD_OBJ),$(LANG_O_BUILD)))
	$(if $(filter 1,$(DEBUG_CC)), @echo $(CC) $(_ARGS_CC) -o $(_DIR_BUILD_OBJ)$(@F) -c $< $(CFLAGS))
	@$(CC) $(_ARGS_CC) -o $(_DIR_BUILD_OBJ)$(@F) -c $< $(CFLAGS)
	@echo ------ $(LANG_DONE)

#-------------------------------------------------------------------------------
# Targets with second expansion
#-------------------------------------------------------------------------------

# Everything below this point will be abble to use a second expansion for variables
.SECONDEXPANSION:

# Builds each exectuable
# 
# 1) Checks if the executable must be linked on shared objects or libraries
# 
#    True:  Builds the executable in the build directory by linking the previously generated object file with its dependancies
# 
#    False: Builds the executable in the build directory from the previously generated object file in the build directory
# 
$(_DIR_BUILD_BIN)%: $(_DIR_BUILD_OBJ)%$(EXT_OBJECT) $$(patsubst $$(_STEM),$(_DIR_BUILD_LIB)$$(_STEM)$(EXT_LIB_ARCHIVE),$$(DEPS_LIB_$$(@F))) $$(patsubst $$(_STEM),$(_DIR_BUILD_OBJ)$$(_STEM)$(EXT_OBJECT),$$(DEPS_$$(@F)))
	
	$(if $(DEPS_LIB_$(@F))$(DEPS_$(@F)),\
		\
		@echo\
		&& echo ------ $(subst _TFILE_,$(@F),$(LANG_DEPS_FIND))\
		&& echo $(patsubst %,"\n--------- "%, $(DEPS_$(@F)))"\n"\
		&& echo ------ $(LANG_DONE)\
		&& echo ------ $(subst _TFILE_,$(@F),$(LANG_DEPS_LIB_FIND))\
		&& echo $(patsubst %,"\n--------- "%, $(DEPS_LIB_$(@F)))"\n"\
		&& echo ------ $(LANG_DONE)\
		&& echo ------ $(subst _TFILE_,$(@F),$(LANG_DEPS_SYSLIB_FIND))\
		&& echo $(patsubst %,"\n--------- "%, $(DEPS_SYSLIB_$(@F)))"\n"\
		&& echo ------ $(LANG_DONE)\
		&& echo\
		&& echo ------ $(subst _TFILE_,$(@F),$(subst _DIR_BUILD_,$(_DIR_BUILD_BIN),$(subst _OFILE_,$(_DIR_BUILD_OBJ)$(@F)$(EXT_OBJECT),$(subst _DEPS_,"\n"$(patsubst %,"\n--------- "$(_DIR_BUILD_LIB)%$(EXT_LIB_ARCHIVE),$(DEPS_LIB_$(@F)))$(patsubst %,"\n--------- "$(_DIR_BUILD_OBJ)%$(EXT_OBJECT),$(DEPS_$(@F)))$(patsubst %,"\n--------- -l"%,$(DEPS_SYSLIB_$(@F)))"\n",$(LANG_EXEC_BUILD_HASDEPS)))))\
		&& $(CC) $(if $(findstring Objective-C,$(code)), -framework $(OBJC_FRAMEWORK)) -o $@ $(_DIR_BUILD_OBJ)$(@F)$(EXT_OBJECT) $(patsubst %,$(_DIR_BUILD_LIB)%$(EXT_LIB_ARCHIVE),$(DEPS_LIB_$(@F))) $(patsubst %,$(_DIR_BUILD_OBJ)%$(EXT_OBJECT),$(DEPS_$(@F))) $(patsubst %,"-l"%,$(DEPS_SYSLIB_$(@F))) $(_ARGS_CC) $(CFLAGS)\
		&& echo ------ $(LANG_DONE)\
		,\
		@echo\
		&& echo ------ $(subst _TFILE_,$(@F),$(LANG_DEPS_FIND))\
		&& echo ------ $(LANG_DONE) - $(subst _TFILE_,$(@F),$(LANG_DEPS_NODEPS))\
		&& echo\
		&& echo ------ $(subst _TFILE_,$(@F),$(subst _CFILE_,$<,$(subst _DIR_BUILD_,$(_DIR_BUILD_BIN),$(LANG_EXEC_BUILD_NODEPS))))\
		$(if $(filter 1,$(DEBUG_CC)),&& echo $(CC) $(_ARGS_CC) -o $(_DIR_BUILD_BIN)$(@F) $< $(CFLAGS))\
		&& $(CC) $(_ARGS_CC) -o $(_DIR_BUILD_BIN)$(@F) $< $(CFLAGS)\
		&& echo ------ $(LANG_DONE)\
	)
