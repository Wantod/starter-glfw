#!/bin/sh

rm -r lib/imgui/example
cmake -G "Visual Studio 16 2019" -B build/

cmake --build build/ --config Debug --target client
