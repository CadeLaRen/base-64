#!/usr/bin/env bash

set +h		# disable hashall
shopt -s -o pipefail
set -e 		# Exit on error

PKG_NAME="check"
PKG_VERSION="0.9.13"

TARBALL="${PKG_NAME}-${PKG_VERSION}.tar.gz"
SRC_DIR="${PKG_NAME}-${PKG_VERSION}"

function help() {
    echo -e "--------------------------------------------------------------------------------------------------------------"
    echo -e "Description: The Check package is a unit testing framework for C."
    echo -e "--------------------------------------------------------------------------------------------------------------"
    echo -e ""
}

function prepare() {
    ln -sv "../../sources/$TARBALL" "$TARBALL"
    source "${CONFIG_FILE}"
}

function unpack() {
    tar xf "${TARBALL}"
}

function build() {
    ./configure --prefix="${HOST_TOOLS_DIR}" \
                --build="${HOST}"            \
                --host="${TARGET}"

    make "${MAKE_PARALLEL}"
}

function test() {
    echo ""
}

function instal() {
<<<<<<< refs/remotes/origin/master
    make install
=======
    make "${MAKE_PARALLEL}" install
>>>>>>> Added check package
}

function clean() {
    rm -rf "${SRC_DIR}" "${TARBALL}"
}

# Run the installation procedure
time { help;clean;prepare;unpack;pushd "${SRC_DIR}";build;[[ "${MAKE_TESTS}" = TRUE ]] && test;instal;popd;clean; }
# Verify installation
if [ -f "${HOST_TOOLS_DIR}/bin/checkmk" ]; then
    touch DONE
fi