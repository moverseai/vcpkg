vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO moverseai/g2o
    REF 02a8f5be538dd3c51f8f9d5261bc4e5391559b00
    SHA512 fbf656a128814fa9bb3e510fab58a38deaf90298520b73528be1b3f6bbf7cfedf7ba4526df48ad88e4f866a9b3932cdd6bc97574ec73f0cd67c50d01eff56649
    HEAD_REF master
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" BUILD_LGPL_SHARED_LIBS)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_LGPL_SHARED_LIBS=${BUILD_LGPL_SHARED_LIBS}
        -DG2O_BUILD_EXAMPLES=OFF
        -DG2O_BUILD_APPS=OFF
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/g2o)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    file(GLOB_RECURSE HEADERS "${CURRENT_PACKAGES_DIR}/include/*")
    foreach(HEADER ${HEADERS})
        file(READ ${HEADER} HEADER_CONTENTS)
        string(REPLACE "#ifdef G2O_SHARED_LIBS" "#if 1" HEADER_CONTENTS "${HEADER_CONTENTS}")
        file(WRITE ${HEADER} "${HEADER_CONTENTS}")
    endforeach()
endif()

file(GLOB EXE "${CURRENT_PACKAGES_DIR}/bin/*.exe")
file(GLOB DEBUG_EXE "${CURRENT_PACKAGES_DIR}/debug/bin/*.exe")
if(EXE OR DEBUG_EXE)
    file(REMOVE ${EXE} ${DEBUG_EXE})
endif()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
#file(INSTALL "${SOURCE_PATH}/doc/license-bsd.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright) 

# Handling absolute paths in config.h
file(READ "${CURRENT_PACKAGES_DIR}/include/${PORT}/config.h" _contents)
string(REGEX REPLACE "#define G2O_CXX_COMPILER \"[^\"]+\"" "#define G2O_CXX_COMPILER \"\${CMAKE_CXX_COMPILER_ID} \${CMAKE_CXX_COMPILER}\"" _contents "${_contents}")
string(REGEX REPLACE "#define G2O_SRC_DIR \"[^\"]+\"" "#define G2O_SRC_DIR \"\${PROJECT_SOURCE_DIR}\"" _contents "${_contents}")
file(WRITE "${CURRENT_PACKAGES_DIR}/include/${PORT}/config.h" "${_contents}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/doc/license-bsd.txt")

