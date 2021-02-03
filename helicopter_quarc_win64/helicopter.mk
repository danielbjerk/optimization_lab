# Copyright 2019 Quanser, Inc.
#
# File    : quarc_win64.tmf
#
# Abstract:
#       Real-Time Workshop template makefile for building a standalone
#       QUARC real-time version of a Simulink model using generated
#       C code and the Microsoft Visual C/C++ compiler versions: 6.0, 7.1
#
#       Note that this template is automatically customized by the Real-Time
#       Workshop build procedure to create "<model>.mk"
#
#       The following defines can be used to modify the behavior of the
#       build:
#
#         OPT_OPTS       - Optimization option. See DEFAULT_OPT_OPTS in
#                          vctools.mak for default.
#         OPTS           - User specific options.
#         CPP_OPTS       - C++ compiler options.
#         USER_SRCS      - Additional user sources, such as files needed by
#                          S-functions.
#         USER_INCLUDES  - Additional include paths
#                          (i.e. USER_INCLUDES="-Iwhere-ever -Iwhere-ever2")
#
#       To enable debugging:
#         set DEBUG_BUILD = 1, which will trigger OPTS=-Zi (may vary with
#                               compiler version, see compiler doc) 
#
#       This template makefile is designed to be used with a system target
#       file that contains 'rtwgensettings.BuildDirSuffix' see grt.tlc


#------------------------ Macros read by make_rtw -----------------------------
#
# The following macros are read by the Real-Time Workshop build procedure:
#
#  MAKECMD             - This is the command used to invoke the make utility
#  HOST                - What platform this template makefile is targeted for
#                        (i.e. PC or UNIX)
#  BUILD               - Invoke make from the Real-Time Workshop build procedure
#                        (yes/no)?
#  SYS_TARGET_FILE     - Name of system target file.
#  BUILD_SUCCESS       - String that is used to indicate that the build succeeded

MAKECMD             = nmake
HOST                = PC
BUILD               = yes
SYS_TARGET_FILE     = quarc_win64.tlc
BUILD_SUCCESS	    = ^#^#^# Created

#---------------------- Tokens expanded by make_rtw ---------------------------
#
# The following tokens, when wrapped with "|>" and "<|" are expanded by the
# Real-Time Workshop build procedure.
#
#  MODEL_NAME          - Name of the Simulink block diagram
#  MODEL_MODULES       - Any additional generated source modules
#  MAKEFILE_NAME       - Name of makefile created from template makefile <model>.mk
#  MATLAB_ROOT         - Path to where MATLAB is installed.
#  MATLAB_BIN          - Path to MATLAB executable.
#  S_FUNCTIONS_LIB     - List of S-functions libraries to link.
#  NUMST               - Number of sample times
#  TID01EQ             - yes (1) or no (0): Are sampling rates of continuous task
#                        (tid=0) and 1st discrete task equal.
#  NCSTATES            - Number of continuous states
#  BUILDARGS           - Options passed in at the command line.
#  MULTITASKING        - yes (1) or no (0): Is solver mode multitasking
#  MAT_FILE            - yes (1) or no (0): generate a model.mat file?
#  RELEASE_VERSION     - The release version of MATLAB.
#
#  MODELREFS           - A list of the referenced model names.
#
#  MODELLIB                - The name of the library generated for the model.
#  MODELREF_LINK_LIBS      - A list of referenced model libraries that the top-level model links against.
#  MODELREF_INC_PATH       - The include path to the referenced models.
#  RELATIVE_PATH_TO_ANCHOR - The relative path from the location of the generated makefile to the MATLAB working directory.
#  MODELREF_TARGET_TYPE    - The type of target being built. Possible values are:
#                              NONE - standalone model or top-level model referencing other models.
#                              RTW  - model reference Real-Time Workshop target build.
#                              SIM  - model reference simulation target build.
#

MODEL                = helicopter
MODULES              = helicopter_data.c helicopter_main.c rtGetInf.c rtGetNaN.c rt_nonfinite.c rt_sim.c
MAKEFILE             = helicopter.mk
MATLAB_ROOT          = C:\Program Files\MATLAB\R2020b
ALT_MATLAB_ROOT      = C:\PROGRA~1\MATLAB\R2020b
MATLAB_BIN           = C:\Program Files\MATLAB\R2020b\bin
ALT_MATLAB_BIN       = C:\PROGRA~1\MATLAB\R2020b\bin
#-- Support for parallel builds
START_DIR            = C:\Users\danielbb\Documents\MATLAB\optimization_lab
S_FUNCTIONS_LIB      = C:\PROGRA~1\Quanser\QUARC\lib\win64\hil.lib C:\PROGRA~1\Quanser\QUARC\lib\win64\QUDCFC~1.LIB C:\PROGRA~1\Quanser\QUARC\lib\win64\QUANSE~4.LIB
NUMST                = 2
TID01EQ              = 1
NCSTATES             = 4
COMPUTER             = PCWIN64
BUILDARGS            =  EXT_MODE=1 EXTMODE_STATIC_ALLOC=0 TMW_EXTMODE_TESTING=0 EXTMODE_STATIC_ALLOC_SIZE=1000000 EXTMODE_TRANSPORT=0 SHOW_TIMES=0 DEBUG=0 DEBUG_HEAP=0 INCLUDE_MDL_TERMINATE_FCN=1 OPTS="-DEXT_MODE -DON_TARGET_WAIT_FOR_START=1 -DTID01EQ=1"
MULTITASKING         = 0
RELEASE_VERSION      = R2020b
MAT_FILE             = 0

CODE_INTERFACE_PACKAGING = Nonreusable function

CLASSIC_INTERFACE    = 1
# Optional for GRT
ALLOCATIONFCN        = 0
ONESTEPFCN           = 0
TERMFCN              = 1

#-- Support multi-instance code
MULTI_INSTANCE_CODE  = 0

MODELREFS            = 
TARGET_LANG_EXT      = c
OPTIMIZATION_FLAGS   = 
ADDITIONAL_LDFLAGS   = 
DEFINES_CUSTOM       = 

# To enable debugging:
# set DEBUG_BUILD = 1
DEBUG_BUILD             = 0

#--------------------------- Model and reference models -----------------------

MODELLIB                  = 
MODELREF_LINK_LIBS        = 
MODELREF_LINK_RSPFILE     = helicopter_ref.rsp

COMPILER_COMMAND_FILE     = helicopter_comp.rsp
RELATIVE_PATH_TO_ANCHOR   = ..
# NONE: standalone, SIM: modelref sim, RTW: modelref rtw
MODELREF_TARGET_TYPE      = NONE

#-- In the case when directory name contains space ---
!if "$(MATLAB_ROOT)" != "$(ALT_MATLAB_ROOT)"
MATLAB_ROOT = $(ALT_MATLAB_ROOT)
!endif
!if "$(MATLAB_BIN)" != "$(ALT_MATLAB_BIN)"
MATLAB_BIN = $(ALT_MATLAB_BIN)
!endif
MATLAB_ARCH_BIN = $(MATLAB_BIN)\win64

#--------------------------- Additional options -------------------------------

ASSERTACTION = "Stop model with an error"
HAVESTDIO = 1

#--------------------------- Tool Specifications ------------------------------

APPVER=5.02
CPU=AMD64
!include $(QUARC)\include\vctools.mak

PERL = $(MATLAB_ROOT)\sys\perl\win32\bin\perl

#------------------------------ Include/Lib Path ------------------------------

# Additional file include paths (from rtwmakecfg.m functions)


QUARC_INCLUDES = $(QUARC)\include

INCLUDE = .;$(RELATIVE_PATH_TO_ANCHOR);$(QUARC_INCLUDES);$(BUILDINFO_INCLUDES);$(INCLUDE)

#------------------------ rtModel ----------------------------------------------

RTM_CC_OPTS = -DUSE_RTMODEL

#----------------- Compiler and Linker Options --------------------------------

# Optimization Options. The DEFAULT_OPT_OPTS macro depends on the build configuration.
OPT_OPTS = $(DEFAULT_OPT_OPTS)

# General User Options
!if "$(DEBUG_BUILD)" == "0"
DBG_FLAG =
!else
#   Set OPT_OPTS=-Zi and any additional flags for debugging
DBG_FLAG = -Zi
!endif

SUPRESS_WARNINGS = /wd4100

!if "$(OPTIMIZATION_FLAGS)" != ""
CC_OPTS = $(OPTS) $(RTM_CC_OPTS) $(OPTIMIZATION_FLAGS) $(SUPRESS_WARNINGS)
!else
CC_OPTS = $(OPT_OPTS) $(OPTS) $(RTM_CC_OPTS) $(SUPRESS_WARNINGS)
!endif

ACTION = $(ASSERTACTION:"Ignore"=0)
ACTION = $(ACTION:"Stop model with an error"=1)
ACTION = $(ACTION:"Print assertion"=2)

ASSERT_DEFINES = -DASSERTIONS=$(ACTION)
!if $(ACTION) > 0
ASSERT_DEFINES = $(ASSERT_DEFINES) -DDOASSERTS
!endif

!if $(HAVESTDIO)
STDIO_DEFINES = -DHAVESTDIO
!else
STDIO_DEFINES =
!endif

!if $(COMPILER_VERSION) >= 14
STDIO_LIBS = legacy_stdio_definitions.lib
!endif

CPP_REQ_DEFINES = -DMODEL=$(MODEL) -DRT -DNUMST=$(NUMST) \
		  -DTID01EQ=$(TID01EQ) -DNCSTATES=$(NCSTATES) \
		  -DMULTITASKING=$(MULTITASKING) -DMT=$(MULTITASKING) $(STDIO_DEFINES) -DMAT_FILE=$(MAT_FILE) \
		  -DVXWORKS -DQUARC -DTARGET_TYPE=win64 \
		  -D_CRT_SECURE_NO_DEPRECATE $(ASSERT_DEFINES) \
          -DONESTEPFCN=$(ONESTEPFCN) -DTERMFCN=$(TERMFCN) \
		  -DMULTI_INSTANCE_CODE=$(MULTI_INSTANCE_CODE) \
		  -DCLASSIC_INTERFACE=$(CLASSIC_INTERFACE) \
		  -DALLOCATIONFCN=$(ALLOCATIONFCN) \
		  $(DEFINES_CUSTOM)

!if "$(DEBUG)" == "1"
NODEFAULTFLAGS = /NODEFAULTLIB:libc.lib /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrt.lib \
                 /NODEFAULTLIB:libcd.lib /NODEFAULTLIB:libcmtd.lib /NODEFAULTLIB:msvcprt.lib
!else
NODEFAULTFLAGS = /NODEFAULTLIB:libc.lib /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrtd.lib \
                 /NODEFAULTLIB:libcd.lib /NODEFAULTLIB:libcmtd.lib /NODEFAULTLIB:msvcprtd.lib
!endif

# Uncomment this line to leave warning level at W4
cflags = $(cflags:W4=W3)

# Remove the -Wp64 flag since it is deprecated and the 64-bit compiler checks by default
#cflags = $(cflags:-Wp64=)

CFLAGS   = $(cflags) @$(COMPILER_COMMAND_FILE) $(cvarsdll) /wd4996 $(DBG_FLAG) $(CC_OPTS)\
	   $(CPP_REQ_DEFINES) $(USER_INCLUDES)
CPPFLAGS = $(cflags) @$(COMPILER_COMMAND_FILE) $(cvarsdll) /wd4996 /EHsc- $(DBG_FLAG) \
	   $(CPP_OPTS) $(CC_OPTS) $(CPP_REQ_DEFINES) $(USER_INCLUDES)
LDFLAGS  = $(ldebug) $(conflags) $(NODEFAULTFLAGS) $(conlibs) libcpmt.lib winmm.lib $(STDIO_LIBS) $(ADDITIONAL_LDFLAGS)

#----------------------------- Source Files -----------------------------------

# Standalone executable
!if "$(MODELREF_TARGET_TYPE)" == "NONE"
PRODUCT  = $(RELATIVE_PATH_TO_ANCHOR)\$(MODEL)$(TARGET_EXT)
REQ_SRCS = $(MODEL).$(TARGET_LANG_EXT) $(MODULES)

# Model Reference Target
!else
PRODUCT  = $(MODELLIB)
REQ_SRCS = $(MODULES)
!endif

USER_SRCS =

SRCS = $(REQ_SRCS) $(USER_SRCS)
OBJS_CPP_UPPER = $(SRCS:.CPP=.obj)
OBJS_CPP_LOWER = $(OBJS_CPP_UPPER:.cpp=.obj)
OBJS_C_UPPER = $(OBJS_CPP_LOWER:.C=.obj)
OBJS = $(OBJS_C_UPPER:.c=.obj)

# ------------------------- Additional Libraries ------------------------------

# Set library search path
LIB = $(QUARC)\lib\win64;$(LIB)

# Set QUARC libraries
QUARC_LIBS = extmode_quarc_r2013b.lib quanser_communications.lib quanser_runtime.lib quanser_common.lib ippccmt.lib ippcvmt.lib ippimt.lib ippsmt.lib ippvmmt.lib ippcoremt.lib shell32.lib

LIBS = 


LIBS = $(LIBS)

# ---------------------------- Linker Script ----------------------------------
CMD_FILE       = $(MODEL).rsp
GEN_RSP_SCRIPT = $(MATLAB_ROOT)\rtw\c\tools\mkvc_rsp.pl

!if "$(DEBUG)" == "1"
MANIFEST_BASENAME=$(MODEL).Debug
!else
MANIFEST_BASENAME=$(MODEL)
!endif

#--------------------------------- Rules --------------------------------------
all: set_environment_variables $(PRODUCT)

!if "$(MODELREF_TARGET_TYPE)" == "NONE"
#--- Stand-alone model ---
$(PRODUCT) : $(OBJS) $(LIBS) $(MODELREF_LINK_LIBS) $(MANIFEST_BASENAME).auto.res
	@cmd /C "echo ### Linking ..."
	"$(PERL)" "$(GEN_RSP_SCRIPT)" $(CMD_FILE) $(OBJS) $(MODELREF_LINK_LIBS)
	$(LD) $(LDFLAGS) /MANIFESTFILE:$(MODEL).manifest $(S_FUNCTIONS_LIB) $(LIBS) $(MAT_LIBS) @$(CMD_FILE) @$(MODELREF_LINK_RSPFILE) $(QUARC_LIBS) -out:$@
	@if exist $(MODEL).manifest \
		$(MT) -nologo -manifest $(MODEL).manifest -out:$(MANIFEST_BASENAME).auto.manifest \
		& if "%ERRORLEVEL%" == "0" \
			$(RC) /r $(MANIFEST_BASENAME).auto.rc \
			& echo foo $(LD) $(LDFLAGS) /MANIFESTFILE:$(MODEL).manifest $(S_FUNCTIONS_LIB) $(LIBS) $(MAT_LIBS) @$(CMD_FILE) @$(MODELREF_LINK_RSPFILE) $(QUARC_LIBS) $(MANIFEST_BASENAME).auto.res -out:$@	
	@cmd /C "echo $(BUILD_SUCCESS) executable $(PRODUCT)"
!else
#--- Model reference Coder Target ---
$(PRODUCT) : $(OBJS)
	@cmd /C "echo ### Linking ..."
	"$(PERL)" "$(GEN_RSP_SCRIPT)" $(CMD_FILE) $(OBJS)
	$(LD) -lib /OUT:$(MODELLIB) @$(CMD_FILE)
	@cmd /C "echo $(BUILD_SUCCESS) static library $(MODELLIB)"
!endif

!if "$(CLASSIC_INTERFACE)" ==  "1"
!else
!if "$(TARGET_LANG_EXT)" ==  "cpp"
{$(MATLAB_ROOT)\rtw\c\src\common}.cpp.obj :
	@cmd /C "echo ### Compiling $<"
	$(CC) /TP $(CPPFLAGS) $<

{$(MATLAB_ROOT)\rtw\c\src\common}.c.obj :
	@cmd /C "echo ### Compiling $<"
	$(CC) /TP $(CPPFLAGS) $<
!else
{$(MATLAB_ROOT)\rtw\c\src\common}.c.obj :
	@cmd /C "echo ### Compiling $<"
	$(CC) $(CFLAGS) $<
!endif
!endif

{$(MATLAB_ROOT)\rtw\c\src}.c.obj :
	@echo ### Compiling $<
	$(CC) $(CFLAGS) $<

# Additional sources
{$(MATLAB_ROOT)\rtw\c\src}.c.obj :
	@echo ### Compiling $<
	$(CC) $(CFLAGS) $<

{$(MATLAB_ROOT)\simulink\src}.c.obj :
	@echo ### Compiling $<
	$(CC) $(CFLAGS) $<

{$(MATLAB_ROOT)\rtw\c\src\ext_mode\common}.c.obj :
	@echo ### Compiling $<
	$(CC) $(CFLAGS) $<

{$(MATLAB_ROOT)\toolbox\coder\rtiostream\src\utils}.c.obj :
	@echo ### Compiling $<
	$(CC) $(CFLAGS) $<

rt_sim.obj : $(MATLAB_ROOT)\rtw\c\src\rt_sim.c
	@echo ### Compiling $(MATLAB_ROOT)\rtw\c\src\rt_sim.c
	$(CC) $(CFLAGS) $(MATLAB_ROOT)\rtw\c\src\rt_sim.c



{$(MATLAB_ROOT)\rtw\c\src}.cpp.obj :
	@echo ### Compiling $<
	$(CC) $(CPPFLAGS) $<

{$(MATLAB_ROOT)\simulink\src}.cpp.obj :
	@echo ### Compiling $<
	$(CC) $(CPPFLAGS) $<

{$(MATLAB_ROOT)\rtw\c\src\ext_mode\common}.cpp.obj :
	@echo ### Compiling $<
	$(CC) $(CPPFLAGS) $<

{$(MATLAB_ROOT)\toolbox\coder\rtiostream\src\utils}.cpp.obj :
	@echo ### Compiling $<
	$(CC) $(CPPFLAGS) $<



# Look in QUARC helper files
{$(QUARC)\quarc}.c.obj :
	@echo ### Compiling $<
	$(CC) $(CFLAGS) $<

{$(QUARC)\src}.c.obj :
	@echo ### Compiling $<
	$(CC) $(CFLAGS) $<

# Put these rule last, otherwise nmake will check toolboxes first

{$(RELATIVE_PATH_TO_ANCHOR)}.c.obj :
	@echo ### Compiling $<
	$(CC) $(CFLAGS) $<

{$(RELATIVE_PATH_TO_ANCHOR)}.cpp.obj :
	@echo ### Compiling $<
	$(CC) $(CPPFLAGS) $<

.c.obj :
	@echo ### Compiling $<
	$(CC) $(CFLAGS) $<

.cpp.obj :
	@echo ### Compiling $<
	$(CC) $(CPPFLAGS) $<

set_environment_variables:
	@set INCLUDE=$(INCLUDE)
	@set LIB=$(LIB)

# Libraries. See rtwmakecfg.m documentation.





#----------------------------- Dependencies -----------------------------------

$(OBJS) : $(MAKEFILE) rtw_proj.tmw

$(MANIFEST_BASENAME).auto.res:	$(MANIFEST_BASENAME).auto.rc

$(MANIFEST_BASENAME).auto.rc:	$(MANIFEST_BASENAME).auto.manifest
	@type > nul: <<$@
#include <winuser.rh>
1 RT_MANIFEST "$(MANIFEST_BASENAME).auto.manifest"
<< KEEP

$(MANIFEST_BASENAME).auto.manifest:
	@type > nul: <<$@
<?xml version='1.0' encoding='UTF-8' standalone='yes'?>
<assembly xmlns='urn:schemas-microsoft-com:asm.v1' manifestVersion='1.0'>
  <ms_asmv2:trustInfo xmlns:ms_asmv2="urn:schemas-microsoft-com:asm.v2">
      <ms_asmv2:security>
         <ms_asmv2:requestedPrivileges>
            <ms_asmv2:requestedExecutionLevel level="asInvoker" uiAccess="false">
            </ms_asmv2:requestedExecutionLevel>
         </ms_asmv2:requestedPrivileges>
      </ms_asmv2:security>
   </ms_asmv2:trustInfo>
</assembly>
<< KEEP
	