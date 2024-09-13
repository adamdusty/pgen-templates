if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/{@ project_name @}-${PROJECT_VERSION}"
      CACHE PATH ""
  )
endif()

set(package {@ project_name @})
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# Set up export components
install(
    TARGETS {@ namespace @}_{@ project_name @}
    EXPORT {@ project_name @}Targets
    RUNTIME COMPONENT {@ project_name @}_Runtime
    LIBRARY COMPONENT {@ project_name @}_Runtime
    NAMELINK_COMPONENT {@ project_name @}_Development
    ARCHIVE COMPONENT {@ project_name @}_Development
    FILE_SET {@ project_name @}_headers
)

# Write package file for installations
write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    VERSION ${PACKAGE_VERSION}
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    {@ project_name @}_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced({@ project_name @}_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${{@ project_name @}_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT {@ project_name @}_Development
)

# Install ConfigVersion file
install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${{@ project_name @}_INSTALL_CMAKEDIR}"
    COMPONENT {@ project_name @}_Development
)

install(
    EXPORT {@ project_name @}Targets
    NAMESPACE {@ namespace @}::
    DESTINATION "${{@ project_name @}_INSTALL_CMAKEDIR}"
    COMPONENT {@ project_name @}_Development
)

# Include CPack
if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
