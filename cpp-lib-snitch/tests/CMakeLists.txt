cmake_minimum_required(VERSION 3.27)

project(
    {@ project_name @}Tests
    LANGUAGES CXX
)

# If test project is built independently, find the project package
if(PROJECT_IS_TOP_LEVEL)
    find_package({@ project_name @} REQUIRED)
    enable_testing()
endif()

# Get the testing library
include(FetchContent)
FetchContent_Declare(
    snitch
    GIT_REPOSITORY https://github.com/snitch-org/snitch.git
    GIT_TAG        v1.2.5
    SYSTEM
)
FetchContent_MakeAvailable(snitch)

# Add test exe
add_executable({@ project_name @}_tests)

# Add test sources
target_sources({@ project_name @}_tests PRIVATE
    src/{@ project_name @}_tests.cpp
)

# Link libs
target_link_libraries({@ project_name @}_tests PRIVATE {@ namespace @}::{@ project_name @} snitch::snitch)

# Add test
add_test(NAME {@ project_name @}_tests COMMAND {@ project_name @}_tests)

# Enable test binary to find the DLL if building a shared lib
if(BUILD_SHARED_LIBS)
    set(DLL_DIRS "$<TARGET_RUNTIME_DLL_DIRS:{@ project_name @}_tests>")
    set(ENV_OP "PATH=path_list_append:")

    set_tests_properties({@ project_name @}_tests PROPERTIES
        ENVIRONMENT_MODIFICATION
            "${ENV_OP}$<JOIN:${DLL_DIRS},$<SEMICOLON>${ENV_OP}>"
    )
endif()
