# ┌──────────────────────────────────────────────────────────────────┐
# │  Projects Settings                                               │
# └──────────────────────────────────────────────────────────────────┘
cmake_minimum_required(VERSION 3.12)
project(starter)

include(ExternalProject)
set(CLIENT_NAME client)
# set(TEST_NAME test)

message("Generation avec la configuration ${CMAKE_CONFIGURATION_TYPES} ${CMAKE_BUILD_TYPE}")
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin/)
set(RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

SET( CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/bin/Debug/")
SET( CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/bin/Release/")
SET( CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/bin/Debug/")
SET( CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/bin/Release/")
SET( CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/bin/Debug/")
SET( CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/bin/Release/")

# ┌──────────────────────────────────────────────────────────────────┐
# │  Compilation flags                                               │
# └──────────────────────────────────────────────────────────────────┘

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

if(WIN32)
    set(LIBS glfw opengl32)
elseif(UNIX AND NOT APPLE)
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall")
    find_package(OpenGL REQUIRED)
    add_definitions(${OPENGL_DEFINITIONS})
    find_package(X11 REQUIRED)
    # note that the order is important for setting the libs
    # use pkg-config --libs $(pkg-config --print-requires --print-requires-private glfw3) in a terminal to confirm
    set(LIBS ${GLFW3_LIBRARY} X11 Xrandr Xinerama Xi Xxf86vm Xcursor GL dl pthread)
    set (CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -ldl")
elseif(APPLE)
    INCLUDE_DIRECTORIES(/System/Library/Frameworks)
    FIND_LIBRARY(COCOA_LIBRARY Cocoa)
    FIND_LIBRARY(OpenGL_LIBRARY OpenGL)
    FIND_LIBRARY(IOKit_LIBRARY IOKit)
    FIND_LIBRARY(CoreVideo_LIBRARY CoreVideo)
    MARK_AS_ADVANCED(COCOA_LIBRARY OpenGL_LIBRARY)
    SET(APPLE_LIBS ${COCOA_LIBRARY} ${IOKit_LIBRARY} ${OpenGL_LIBRARY} ${CoreVideo_LIBRARY})
    SET(APPLE_LIBS ${APPLE_LIBS} ${GLFW3_LIBRARY})
    set(LIBS ${LIBS} ${APPLE_LIBS})
else()
    set(LIBS )
endif(WIN32)

# ┌──────────────────────────────────────────────────────────────────┐
# │  Load libraries                                                  │
# └──────────────────────────────────────────────────────────────────┘

set(LIBSC EXTC)
set(LIBS ${LIBSC} ${LIBS} IMGUI GLAD STB_IMAGE freetype OpenAL)

add_subdirectory(${CMAKE_SOURCE_DIR}/lib/)

# ┌──────────────────────────────────────────────────────────────────┐
# │  Build executable                                                │
# └──────────────────────────────────────────────────────────────────┘

#EXECUTABLE_OUTPUT_PATH

add_custom_target(
    copy-shaders ALL
    COMMENT "[INFO] Copying shared files ..."
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_CURRENT_SOURCE_DIR}/resources ${EXECUTABLE_OUTPUT_PATH}/resources
)

# client
file(GLOB_RECURSE PROJET_SRC src/*.cpp src/*.hpp)
add_executable(${CLIENT_NAME}  ${PROJET_SRC})
target_link_libraries(${CLIENT_NAME} ${LIBS})

# add_dependencies(${CLIENT_NAME} copy-shaders)
# test
# add_library(Catch INTERFACE)
# target_include_directories(Catch INTERFACE lib/Catch2/single_include/)
# file(GLOB_RECURSE TEST_SRC src/test/*.cpp src/test/*.hpp)
# add_executable(${TEST_NAME} "src/main_test.cpp" ${TEST_SRC} ${PROJET_SRC} ${PROJECT_SERVER_SRC})
# target_link_libraries(${TEST_NAME} ${LIBS} Catch)
# enable_testing()
# add_test(test_main ${TEST_NAME})
# install(TARGETS ${TEST_NAME} DESTINATION bin)

include_directories(
	${CMAKE_SOURCE_DIR}/src/
)

# Error warning
if ( CMAKE_COMPILER_IS_GNUCC )
    target_compile_options(${CLIENT_NAME} PRIVATE "-Wall")
    # target_compile_options(${TEST_NAME} PRIVATE "-Wall")
endif()

if ( MSVC )
    target_compile_options(${CLIENT_NAME} PRIVATE "/W4")
    # target_compile_options(${TEST_NAME} PRIVATE "/W4")
endif()