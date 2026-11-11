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
test "${CONDA_BUILD_CROSS_COMPILATION}" != "1" && ctest # || true
#test "${CONDA_BUILD_CROSS_COMPILATION}" != "1" && ctest --rerun-failed --output#-on-failure || true
#
#
#HDF5REGISTER="--register manual"
#
#echo "**** Create convert_minicbf-v1 feature"
##which convert_minicbf
#bin/convert_minicbf                                                   \
#    -p "${SRC_DIR}/cbflib/templates/template_pilatus6m_2463x2527.cbf" \
#    -d pilatus6m -v 1                                                 \
#    "${SRC_DIR}/data-input/insulin_pilatus6m.cbf"                     \
#    insulin_pilatus6mconverted.cbf
#
#echo "**** Create cif2cbf-opaque feature"
##which cif2cbf
#bin/cif2cbf -5 w -O ${HDF5REGISTER}      \
#    -i insulin_pilatus6mconverted.cbf    \
#    -o insulin_pilatus6mconverted.cbf.h5
#
#echo "**** Create cif2cbf-opaque-dump feature"
#which h5dump
##which cbf_tail
#h5dump insulin_pilatus6mconverted.cbf.h5     \
#    | bin/cbf_tail -n 1                      \
#    > insulin_pilatus6mconverted.cbf.h5.dump
#
#echo "**** Create insulin-orig-dump-feature"
#h5dump "${SRC_DIR}/data-output/insulin_pilatus6mconverted_orig.cbf.h5" \
#    | bin/cbf_tail -n 1                                                \
#    > insulin_pilatus6mconverted_orig.cbf.h5.dump
#
#echo "**** Diff insulin-orig-dump and cif2cbf-opaque-dump features"
#ls -l                                           \
#    insulin_pilatus6mconverted_orig.cbf.h5.dump \
#    insulin_pilatus6mconverted.cbf.h5.dump
#diff -u                                         \
#    insulin_pilatus6mconverted_orig.cbf.h5.dump \
#    insulin_pilatus6mconverted.cbf.h5.dump
#
#
cmake --install . --component Development
cmake --install . --component Runtime
