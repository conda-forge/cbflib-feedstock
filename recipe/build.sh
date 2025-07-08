#! /bin/sh

cmake ${CMAKE_ARGS}                                      \
    -DCBF_WITH_DATA_INPUT:PATH="${SRC_DIR}/data-input"   \
    -DCBF_WITH_DATA_OUTPUT:PATH="${SRC_DIR}/data-output" \
    -DCBF_ENABLE_FORTRAN:BOOL=OFF                        \
    -DCBF_ENABLE_JAVA:BOOL=OFF                           \
    -DCBF_ENABLE_PYTHON:BOOL=OFF                         \
    -DCBF_WITH_CQRLIB:BOOL=OFF                           \
    -DCBF_WITH_HDF5:BOOL=OFF                             \
    -DCBF_WITH_LIBTIFF:BOOL=OFF                          \
    -DCBF_WITH_PCRE2:BOOL=OFF                            \
    "${SRC_DIR}/cbflib"

cmake --build .
test "${CONDA_BUILD_CROSS_COMPILATION}" != "1" && ctest
cmake --install . --component Development
cmake --install . --component Runtime
