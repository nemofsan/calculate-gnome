# Copyright 2023 Calculate Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

COMMIT="41e982715d6a83893c64273184f263bb99be93e7"

DESCRIPTION="rtl88x2bu driver updated for current kernels"
HOMEPAGE="https://github.com/cilynx/rtl88x2bu"
SRC_URI="https://github.com/cilynx/rtl88x2bu/archive/${COMMIT}.tar.gz -> rtl88x2bu-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/linux-sources"
DEPEND="${RDEPEND}"

S="${WORKDIR}/rtl88x2bu-${COMMIT}"

MODULE_NAMES="88x2bu(net/wireless)"
BUILD_TARGETS="clean modules"
BUILD_TARGET_ARCH="${ARCH}"

pkg_setup() {
	if ! use kernel_linux ; then
		die "Unable to install"
	fi
	
	linux-mod_pkg_setup
	BUILD_PARAMS="KERN_DIR=${KV_DIR} KSRC=${KV_DIR} KERN_VER=${KV_FULL} O=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=1"
}

src_compile(){
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
}

