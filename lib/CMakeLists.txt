include_directories(
    ${CMAKE_SOURCE_DIR}/lib/exts/include/
    ${CMAKE_SOURCE_DIR}/lib/imgui/
	${CMAKE_SOURCE_DIR}/lib/freetype2/include/
	${CMAKE_SOURCE_DIR}/lib/openal-soft/include/
	${CMAKE_SOURCE_DIR}/lib/glfw/include/
	${CMAKE_SOURCE_DIR}/lib/glm/
	${CMAKE_SOURCE_DIR}/lib/stb/
)

option(GLFW_BUILD_EXAMPLES "Build the GLFW example programs" OFF)
option(GLFW_BUILD_TESTS "Build the GLFW test programs" OFF)
option(GLFW_BUILD_DOCS "Build the GLFW documentation" OFF)
option(GLFW_INSTALL "Generate installation target" OFF)
option(GLM_TEST_ENABLE "Build unit tests"  OFF)

OPTION(ALSOFT_DLOPEN  "Check for the dlopen API for loading optional libs"  OFF)
OPTION(ALSOFT_UTILS          "Build and install utility programs"         OFF)
OPTION(ALSOFT_NO_CONFIG_UTIL "Disable building the alsoft-config utility" OFF)
OPTION(ALSOFT_EXAMPLES  "Build and install example programs"  OFF)
OPTION(ALSOFT_TESTS     "Build and install test programs"    OFF)
OPTION(ALSOFT_INSTALL "Install headers and libraries" ON)

add_library(STB_IMAGE "${CMAKE_SOURCE_DIR}/lib/exts/stb_image.cpp")
add_library(GLAD "${CMAKE_SOURCE_DIR}/lib/exts/src/glad.c")
file(GLOB_RECURSE IMGUI_SRC ${CMAKE_SOURCE_DIR}/lib/imgui/*.cpp)
add_library(IMGUI "${IMGUI_SRC}")
add_library(EXTC "${CMAKE_SOURCE_DIR}/lib/exts/miniz.c")

add_subdirectory(${CMAKE_SOURCE_DIR}/lib/openal-soft/ )
add_subdirectory(${CMAKE_SOURCE_DIR}/lib/freetype2/)
add_subdirectory(${CMAKE_SOURCE_DIR}/lib/glfw/)
add_subdirectory(${CMAKE_SOURCE_DIR}/lib/glm/)
