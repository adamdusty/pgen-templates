cmake_minimum_required(VERSION 3.29)

project(
    {@ project_name @}
    VERSION 0.1.0
    DESCRIPTION "A short description"
    LANGUAGES CXX
)

# Include utilities
include(cmake/options.cmake)
include(cmake/warning-guard.cmake)
include(cmake/compile-options.cmake)
include(cmake/dependencies.cmake)

# Declare library
add_library({@ namespace @}_{@ project_name @})
add_library({@ namespace @}::{@ project_name @} ALIAS {@ namespace @}_{@ project_name @})

# Generate header for export
include(GenerateExportHeader)
generate_export_header(
    {@ namespace @}_{@ project_name @}
    BASE_NAME {@ project_name @}
    EXPORT_FILE_NAME ${CMAKE_CURRENT_SOURCE_DIR}/include/{@ namespace @}/export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

# Add sources
target_sources({@ namespace @}_{@ project_name @}
    PUBLIC
        FILE_SET    {@ project_name @}_headers
        TYPE        HEADERS
        BASE_DIRS   include
        FILES
            "include/{@ namespace @}/{@ project_name @}.hpp"
    PRIVATE
        "src/{@ project_name @}.cpp"
)
# Include and link dependencies
#target_link_libraries({@ namespace @}_{@ project_name @})

# Add compile options
target_compile_options({@ namespace @}_{@ project_name @} PRIVATE ${{@ project_name @}_COMPILE_OPTIONS})


# Set properties
set_target_properties(
    {@ namespace @}_{@ project_name @} PROPERTIES
    CXX_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME {@ project_name @}
    OUTPUT_NAME {@ project_name @}
)

# Install rules
if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# Enable testing
if(BUILD_TESTING)
    include(CTest)
    add_subdirectory(tests)
endif()
