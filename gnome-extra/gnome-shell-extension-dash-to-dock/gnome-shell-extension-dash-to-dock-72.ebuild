# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils

MY_PN="${PN/gnome-shell-extension-/}"

COMMIT="19cc612c53d33e7c529c116a096bf78c66caae29"

DESCRIPTION="A dock for the Gnome Shell"
HOMEPAGE="https://github.com/micheleg/dash-to-dock"
SRC_URI="https://github.com/micheleg/dash-to-dock/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND="
	dev-libs/glib:2
	dev-lang/sassc
"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-40
"
DEPEND="${COMMON_DEPEND}"

BDEPEND=""

S="${WORKDIR}/${MY_PN}-${COMMIT}"
extension_uuid="dash-to-dock@micxgx.gmail.com"

src_prepare() {
	default

	# Set correct version
	export VERSION="${PV}"

	# Don't install README and COPYING in unwanted locations
	sed -i -e 's/COPYING//g' -e 's/README.md//g' Makefile || die
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

