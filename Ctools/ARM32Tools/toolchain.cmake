# name of target system
set(CMAKE_SYSTEM_NAME Generic)

# cross compiler
set(CMAKE_C_COMPILER    arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER  arm-none-eabi-g++)

# root file path
set(CMAKE_FIND_ROOT_PATH $ENV{GCC_ARM_LIB_PATH})

# set default find_xxx behaviour
# https://cmake.org/cmake/help/book/mastering-cmake/chapter/Cross%20Compiling%20With%20CMake.html
# 
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)