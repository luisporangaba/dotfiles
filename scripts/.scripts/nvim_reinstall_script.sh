#!/bin/sh
# Execute this script inside nvim repo

cmake --build build/ --target uninstall

rm -r build/  # clear CMake cache

# Other CMAKE_BUILD_TYPE flags:
# Debug: For debugging
# RelWithDebInfo: Build that is fast but still debuggable
# Release: No debug needed
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/Builds/nvim/neovim_build

make install

