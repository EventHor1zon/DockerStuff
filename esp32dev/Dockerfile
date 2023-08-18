#syntax=docker/dockerfile:1
#
# Attempt at a docker container for developing ESP32 applications
#


FROM ubuntu:22.04

ENV USERNAME="dev"
# log file
ENV LOGNAME="log.txt"
# directories
ENV SRCDIR=/src
ENV TOOLDIR=/tools
ENV TOOLCHAIN_URL="https://github.com/espressif/esp-idf.git"
ENV IDF_TOOLS_PATH=$TOOLDIR/toolchain

RUN mkdir -p -v $IDF_TOOLS_PATH
# make config directory and home dir for neovim :)
RUN mkdir -p -v /home/$USERNAME/.config/nvim/

# update and get build tools
RUN apt-get update
# default build-essential fails w. 404 error so use specific focal version of libcurl4
RUN apt-get install -y wget gcc bison flex gperf python3-venv ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 build-essential ninja-build gettext unzip curl socat cppcheck cmake clang-tools-12 clangd-15 tmux git

RUN ln -s /usr/bin/clangd-15 /usr/bin/clangd
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install esp32 compiler tools
WORKDIR $TOOLDIR
# clone toolchain
RUN git clone -b v5.1 --recursive $TOOLCHAIN_URL
# set new workdir
WORKDIR $TOOLDIR/esp-idf

# install esp-idf for all platforms
RUN ./install.sh all

# add paths to PATH
ENV PATH=${PATH}:$TOOLDIR:$IDF_TOOLS_PATH

# Get neovim and build from source
WORKDIR $TOOLDIR
RUN git clone https://github.com/neovim/neovim
WORKDIR $TOOLDIR/neovim
RUN git checkout stable
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo
RUN make install

# make the source directory
RUN mkdir $SRCDIR
WORKDIR $SRCDIR
RUN touch ./$LOGNAME

# check versions
RUN echo "Installed gcc-arm-none-eabi version "$(arm-none-eabi-gcc --version) >> ./$LOGNAME
RUN echo "Installed ccpcheck version "$(cppcheck --version) >> ./$LOGNAME
RUN echo "Installed neovim version "$(nvim --version) >> ./$LOGNAME
RUN cat ./$LOGNAME
RUN echo "Tool install complete"

