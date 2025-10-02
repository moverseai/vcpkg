vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO moverseai/RxCpp
    REF 5b3b3ba3add6a923dfd3d36b5b24290c1d337ec9
    SHA512 a03ce9e6a829a664a0c148a2e160522823e4affbb033547b26f7925ec963affc8dab49730c185307c52be6cb370d2a3916c51811de5a9d49098c94f446927403
    HEAD_REF moverse
)

set(RXCPP_DISABLE_TESTS_AND_EXAMPLES 1)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH share/${PORT}/cmake/)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)
file(COPY ${SOURCE_PATH}/license.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(RENAME ${CURRENT_PACKAGES_DIR}/share/${PORT}/license.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright)
