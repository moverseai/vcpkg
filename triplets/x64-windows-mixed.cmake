# set(VCPKG_PLATFORM_TOOLSET "v142")
# set(VCPKG_MAX_CONCURRENCY, "1")

set(VCPKG_TARGET_ARCHITECTURE x64)

if(${PORT} MATCHES "onnxruntime-gpu|sqlcipher|openssl|tcl|libusb")
    set(VCPKG_CRT_LINKAGE dynamic)
    set(VCPKG_LIBRARY_LINKAGE dynamic)
else()
	set(VCPKG_CRT_LINKAGE static)
	set(VCPKG_LIBRARY_LINKAGE static)
endif()