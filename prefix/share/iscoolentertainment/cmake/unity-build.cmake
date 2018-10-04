include( ProcessorCount )

function( make_compilation_unit unit_file name extension )

  ProcessorCount( unit_count )
  
  if( ${unit_count} EQUAL 0 )
    set( unit_count 1 )
  endif()

  list( LENGTH ARGN arg_count )
  
  if( ${arg_count} LESS ${unit_count} )
    set( unit_count ${arg_count} )
  endif()
  
  set( temporary_units )

  foreach( unit_index RANGE 1 ${unit_count} )
    set( temp "${PROJECT_BINARY_DIR}/${name}-unit.tmp.${unit_index}" )
    file( REMOVE "${temp}" )
    set( temporary_units ${temporary_units} ${temp} )
  endforeach()

  set( unit_index 0 )
  
  foreach( f ${ARGN} )
    list( GET temporary_units ${unit_index} temp )
    file( APPEND "${temp}" "#include \"${f}\"\n" )

    math( EXPR unit_index "${unit_index} + 1" )

    if( ${unit_index} EQUAL ${unit_count} )
      set( unit_index 0 )
    endif()
  endforeach()

  set( result )

  foreach( unit_index RANGE 1 ${unit_count} )
    set(
      unit
      "${PROJECT_BINARY_DIR}/${name}-unit-${unit_index}.${extension}"
      )
    set( result ${result} ${unit} )

    math( EXPR list_index "${unit_index} - 1" )
    list( GET temporary_units ${list_index} temp )

    execute_process( COMMAND ${CMAKE_COMMAND}
      -E copy_if_different
      "${temp}"
      "${unit}"
      OUTPUT_QUIET
      ERROR_QUIET
      )

    file( REMOVE "${temp}" )
  endforeach()

  set( ${unit_file} ${result} PARENT_SCOPE )
endfunction()
