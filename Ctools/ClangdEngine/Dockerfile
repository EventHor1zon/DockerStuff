#syntax=docker/dockerfile:1
#
# Attempt at a docker container for cleaning, checking, compiling 
# arm programs
#
# Utilities: 
#	gcc-arm-none-eabi   -   arm toolchain version 10.2.1 (2020-q4-major)
#	cppcheck            -   cpp check for checking MISRA-C compliance
#	clang-format	    -   clang formatter version 5.0



FROM ubuntu:20.04
WORKDIR /tools
ENV GCC_ARM_DOWNLOAD_URL=https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
ENV GCC_ARM_FILENAME=gcc-arm-none-eabi-10-2020-q4-major
ENV SHELL=/bin/bash

RUN apt-get update
RUN apt-get install -y wget cppcheck cmake clangd-12

RUN wget $GCC_ARM_DOWNLOAD_URL
RUN tar -xjf ./$GCC_ARM_FILENAME*
ENV PATH=${PATH}:/tools/$GCC_ARM_FILENAME/bin:/tools/$GCC_ARM_FILENAME/arm-none-eabi/bin

RUN echo $PATH

RUN arm-none-eabi-gcc --version
RUN echo "Installed gcc-arm-none-eabi version "$(arm-none-eabi-gcc --version)

RUN cppcheck --version
RUN clang-format-9 --version

RUN echo "Tool install complete"

WORKDIR /src
