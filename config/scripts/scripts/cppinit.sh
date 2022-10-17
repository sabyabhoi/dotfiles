#!/bin/bash

get_project_name() {
	project=$(pwd | awk -F '/' '{print $NF}')
	# Project name
	tmp=$(gum input --placeholder="${project}" --prompt "Project name> ")
	if [[ -n "$tmp" ]]; then
		project=$tmp
	fi
	echo $project
}

git init 

mkdir build include lib src test

git submodule add https://github.com/google/googletest.git lib/googletest

gen_cmake() {
	echo "cmake_minimum_required(VERSION 3.24.2)
project($1)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL \"\") 

include_directories(include)

add_subdirectory(src)
add_subdirectory(test)
add_subdirectory(lib/googletest)
" > CMakeLists.txt


	echo "set(BINARY \${CMAKE_PROJECT_NAME}_test)

add_executable(\${BINARY} test.cpp)
target_link_libraries(\${BINARY} PUBLIC gtest)" > test/CMakeLists.txt

	echo "set(BINARY \${CMAKE_PROJECT_NAME}_run)

#add_library(library library.cpp)

add_executable(\${BINARY} main.cpp)
#target_link_libraries(\${BINARY} library)" > src/CMakeLists.txt
}

gen_cpp_files() {
	echo "int main() {
  return 0;
}" > src/main.cpp

	echo "#include \"gtest/gtest.h\"

int main(int argc, char *argv[]) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}" > test/test.cpp
}

gen_gitignore() {
	echo "/build" > .gitignore
}

gen_cmake $(get_project_name) 
gen_cpp_files
