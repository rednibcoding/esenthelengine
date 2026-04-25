#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=clang
CCC=clang++
CXX=clang++
FC=gfortran
AS=as

# Macros
CND_PLATFORM=GNU-Linux-x86
CND_DLIB_EXT=so
CND_CONF=Debug
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
EE_OBJ_FILES

# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=-m64 -fshort-wchar -fpermissive -ffast-math -ffriend-injection -fms-extensions -fno-pic -fno-pie -Wno-int-to-pointer-cast -Wno-invalid-offsetof -Wno-comment -Wno-parentheses -Wno-switch -Wno-null-dereference -Wno-empty-body -Wno-address-of-temporary -Wno-dynamic-class-memaccess -include stdafx.h
CXXFLAGS=-m64 -fshort-wchar -fpermissive -ffast-math -ffriend-injection -fms-extensions -fno-pic -fno-pie -Wno-int-to-pointer-cast -Wno-invalid-offsetof -Wno-comment -Wno-parentheses -Wno-switch -Wno-null-dereference -Wno-empty-body -Wno-address-of-temporary -Wno-dynamic-class-memaccess -include stdafx.h

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=EE_LIB_PATH \
 ../../../../ThirdPartyLibs/Recast/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Png/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Vorbis/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Theora/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/SQLite/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Webp/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/LZ4/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Ogg/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Tiff/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Waifu2x/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/FreeType/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Bullet/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Snappy/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/LZMA/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/FBX/Linux/libfbxsdk.a \
 ../../../../ThirdPartyLibs/JpegTurbo/Linux/libturbojpeg.a \
 ../../../../ThirdPartyLibs/Flac/Linux/libFLAC-static.a \
 ../../../../ThirdPartyLibs/Opus/Linux/libopusfile.a \
 ../../../../ThirdPartyLibs/Opus/Linux/libopus.a \
 ../../../../ThirdPartyLibs/VP/Linux/libvpx.a \
 ../../../../ThirdPartyLibs/LZHAM/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Zstd/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/FDK-AAC/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/mbedTLS/Linux/dist/Release/GNU-Linux/liblinux.a \
 ../../../../ThirdPartyLibs/Xml2/Linux/libxml2.a \
 ../../../../ThirdPartyLibs/PhysX/physx/bin/linux.clang/release/libPhysX_static_64.a \
 ../../../../ThirdPartyLibs/PhysX/physx/bin/linux.clang/release/libPhysXCharacterKinematic_static_64.a \
 ../../../../ThirdPartyLibs/PhysX/physx/bin/linux.clang/release/libPhysXCooking_static_64.a \
 ../../../../ThirdPartyLibs/PhysX/physx/bin/linux.clang/release/libPhysXExtensions_static_64.a \
 ../../../../ThirdPartyLibs/PhysX/physx/bin/linux.clang/release/libPhysXFoundation_static_64.a \
 ../../../../ThirdPartyLibs/PhysX/physx/bin/linux.clang/release/libPhysXPvdSDK_static_64.a \
 ../../../../ThirdPartyLibs/PhysX/physx/bin/linux.clang/release/libPhysXVehicle_static_64.a \
 ../../../../ThirdPartyLibs/PhysX/physx/bin/linux.clang/release/libPhysXCommon_static_64.a \
 EXTERNAL_LIBS -Wl,-rpath,Bin -lpthread -ldl -lX11 -lXi -lXinerama -lXrandr -lrt -lXmu -lGL -lopenal -lz -lodbc -ludev -lXcursor -lXxf86vm

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk EE_APP_NAME

EE_APP_NAME: EE_LIB_PATH EXTERNAL_LIBS

EE_APP_NAME: ${OBJECTFILES}
	clang++ -o EE_APP_NAME ${OBJECTFILES} ${LDLIBSOPTIONS} -static-libstdc++ -no-pie

EE_CPP_FILES

stdafx.h.pch: stdafx.h
	${MKDIR} -p ..
	@echo Performing Custom Build Step
	clang++ -x c++-header stdafx.h -o stdafx.h.pch $(CXXFLAGS) -g -DDEBUG=1 -I. EE_HEADER_PATH -std=c++17

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} stdafx.h.pch
	${RM} EE_APP_NAME

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
