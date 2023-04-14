cmake_minimum_required( VERSION 3.1 )

project(shell-utils)

set( source_root "${CMAKE_CURRENT_SOURCE_DIR}/../.." )
set( CMAKE_MODULE_PATH
  "${CMAKE_MODULE_PATH}"
  ${source_root}/prefix/share/iscoolentertainment/cmake/
  )

include( uninstall )

install(
  DIRECTORY ${source_root}/prefix/
  DESTINATION .
  USE_SOURCE_PERMISSIONS
  )
