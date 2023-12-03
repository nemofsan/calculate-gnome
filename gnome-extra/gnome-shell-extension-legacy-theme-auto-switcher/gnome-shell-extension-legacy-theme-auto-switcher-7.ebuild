# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils

MY_PN="${PN/gnome-shell-extension-/}-gnome-extension"

COMMIT="1f51c72721b274273b3dd91a3dd59af64bc73110"

DESCRIPTION="Changes the GTK3 (legacy) theme variant to light/dark on Gnome 42 when the scheme is changed from Settings."
HOMEPAGE="https://github.com/mukul29/legacy-theme-auto-switcher-gnome-extension"
SRC_URI="https://github.com/mukul29/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	dev-libs/glib:2
"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-45
"
DEPEND="${COMMON_DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_PN}-${COMMIT}"
extension_uuid="legacyschemeautoswitcher@joshimukul29.gmail.com"

src_prepare() {
	default
	sed -i "s|^\(  \"version\":\).*|\1 ${PV}|g" metadata.json || die
}

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
