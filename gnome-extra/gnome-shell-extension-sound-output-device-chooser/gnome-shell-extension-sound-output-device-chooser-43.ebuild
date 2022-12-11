# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils

MY_PN="${PN/gnome-shell-extension-/}"

COMMIT="9af403cf79c4d27ae3b1aadcda063eeb6b7ecb9f"

DESCRIPTION="A simple selector to enabled selection of sound source and sink based on Gnome Control Center"
HOMEPAGE="https://github.com/kgshank/gse-sound-output-device-chooser"
SRC_URI="https://github.com/kgshank/gse-${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND="dev-libs/glib:2"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-3.32
"
DEPEND="${COMMON_DEPEND}"
BDEPEND=""

S="${WORKDIR}/gse-${MY_PN}-${COMMIT}"
extension_uuid="sound-output-device-chooser@kgshank.net"

src_prepare() {
        eapply "${FILESDIR}"/sound-output-device-chooser-43.patch
        eapply_user
}

src_install() {
	default
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	ebegin "Updating list of installed extensions"
	eselect gnome-shell-extensions update
	eend $?
}

pkg_postrm() {
	gnome2_schemas_update
}


