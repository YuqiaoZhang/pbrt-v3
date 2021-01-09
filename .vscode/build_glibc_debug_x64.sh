#!/bin/bash

#
# Copyright (C) YuqiaoZhang(HanetakaYuminaga)
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

GIT_DIR="$(cd "$(dirname "${0}")/../" 1>/dev/null 2>/dev/null && pwd)"

cd "${GIT_DIR}"
git submodule update --init --recursive

cd "${GIT_DIR}/src"
# rm -rf build
mkdir -p build

cd build 

cmake \
-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
-DCMAKE_C_FLAGS="-fPIE -fPIC -m64" \
-DCMAKE_CXX_FLAGS="-fPIE -fPIC -m64" \
-DCMAKE_EXE_LINKER_FLAGS="-pie -Wl,--no-undefined -m64" \
-DCMAKE_SHARED_LINKER_FLAGS="-Wl,--no-undefined -m64" \
-DCMAKE_MODULE_LINKER_FLAGS="-m64" \
-DCMAKE_BUILD_TYPE=Debug \
-DCMAKE_INSTALL_PREFIX="${GIT_DIR}/src/objs" \
"${GIT_DIR}"

cmake --build . --config Debug --target install -- -j
