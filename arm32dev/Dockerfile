#syntax=docker/dockerfile:1
#
# Attempt at a docker container for cleaning, checking, compiling 
# arm programs
#
# Utilities: 
#	gcc-arm-none-eabi   -   arm toolchain version 10.2.1 (2020-q4-major)
#	cppcheck            -   cpp check for checking MISRA-C compliance
#	clangd-12	        -   clang server to provide linting/code completion etc
#                           support dependent on editor, can bind fornat scripts 
#                           if editor support not available. Remember to open port!


FROM ubuntu:22.04

ENV USERNAME="dev"
# log file
ENV LOGNAME="log.txt"
# directories
ENV SRCDIR=/src
ENV TOOLDIR=/tools
# arm gcc toolchain download path
ENV DOTFILE_REPOSITORY_URL="https://github.com/EventHor1zon/dotfiles.git"
ENV GCC_ARM_DOWNLOAD_URL=https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
ENV GCC_ARM_FILENAME=gcc-arm-none-eabi-10-2020-q4-major

# make user and home dir
RUN useradd -m -U $USERNAME
RUN mkdir -p -v /home/$USERNAME/.config/
ENV USER_HOMEDIR=/home/$USERNAME/
ENV CFGDIR=$USER_HOMEDIR/.config

# update and get build tools
RUN apt-get update

# default build-essential fails w. 404 error so use specific focal version of libcurl4
RUN apt-get install -y wget gcc build-essential ninja-build gettext unzip curl socat cppcheck cmake clang-tools-12 clangd-15 tmux git

RUN ln -s /usr/bin/clangd-15 /usr/bin/clangd

# Install arm cross compiler tools
WORKDIR $TOOLDIR
# download & unzip toolchain
RUN wget $GCC_ARM_DOWNLOAD_URL
RUN tar -xjf ./$GCC_ARM_FILENAME*
# export paths
ENV GCC_ARM_UTILS_PATH=$TOOLDIR/$GCC_ARM_FILENAME/arm-none-eabi/bin/
ENV GCC_PATH=$TOOLDIR/$GCC_ARM_FILENAME/bin/
ENV GCC_ARM_LIB_PATH=$TOOLDIR/$GCC_ARM_FILENAME/lib
# add paths to PATH
ENV PATH=${PATH}:$GCC_ARM_UTILS_PATH:$GCC_PATH

# Get neovim and build from source
RUN git clone https://github.com/neovim/neovim
WORKDIR $TOOLDIR/neovim
RUN git checkout stable
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo
RUN make install

# import my configuration files
# TODO: comment this out if not required
RUN git clone DOTFILE_REPOSITORY_URL
RUN mv dotfiles/nvim/ $CFGDIR
RUN mv dotfiles/.bashrc $USER_HOMEDIR
RUN mv dotfiles/.tmux.conf $USER_HOMEDIR
RUN rm -rf dotfiles

# make the source directory
RUN mkdir $SRCDIR
WORKDIR /src
RUN touch ./$LOGNAME

# check versions
RUN echo "Installed gcc-arm-none-eabi version "$(arm-none-eabi-gcc --version) >> ./$LOGNAME
RUN echo "Installed ccpcheck version "$(cppcheck --version) >> ./$LOGNAME
RUN echo "Installed neovim version "$(nvim --version) >> ./$LOGNAME
RUN cat ./$LOGNAME
RUN echo "Tool install complete"

# attempt nvim copy?
RUN mkdir /root/.config

