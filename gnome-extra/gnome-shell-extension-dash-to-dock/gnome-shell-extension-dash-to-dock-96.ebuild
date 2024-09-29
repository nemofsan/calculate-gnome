# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils

MY_PN="${PN/gnome-shell-extension-/}"
MY_P="${MY_PN}-extensions.gnome.org-v${PV}"

DESCRIPTION="A dock for the Gnome Shell"
HOMEPAGE="https://github.com/micheleg/dash-to-dock"
SRC_URI="https://github.com/micheleg/${MY_PN}/archive/${MY_P/${MY_PN}-/}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="dev-libs/glib:2"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-45
"
DEPEND="${COMMON_DEPEND}"
BDEPEND="
	dev-lang/sassc
	dev-util/intltool
	sys-devel/gettext
"

S="${WORKDIR}/${MY_P}"
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

