# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils

DESCRIPTION="No overview at start-up. For GNOME Shell 40+"
HOMEPAGE="https://github.com/fthx/no-overview"
SRC_URI="https://github.com/fthx/no-overview/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND="
	dev-libs/glib:2
"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-40.0
"
DEPEND="${COMMON_DEPEND}"
BDEPEND=""

S="${WORKDIR}/no-overview-${PV}"
extension_uuid="no-overview@fthx"

# Not useful for us
src_compile() { :; }

src_install() {
	einstalldocs
	rm -f README.md LICENSE || die
	insinto /usr/share/gnome-shell/extensions/"${extension_uuid}"
	doins -r *
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
