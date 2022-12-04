# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils meson

MY_PN="${PN/gnome-shell-extension-/}"

DESCRIPTION="Put Gnome Tweaks and Extensions (on Shell 40 and later) in the System menu"
HOMEPAGE="https://github.com/F-i-f/tweaks-system-menu"
SRC_URI="https://github.com/F-i-f/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND="dev-libs/glib:2"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-40.0
"
DEPEND="${COMMON_DEPEND}"
BDEPEND="
	virtual/pkgconfig
        >=dev-util/meson-0.50.0
"

S="${WORKDIR}/${MY_PN}-${PV}"
extension_uuid="tweaks-system-menu@extensions.gnome-shell.fifi.org"


src_prepare() {
	 eapply "${FILESDIR}"/${MY_PN}-build-meson.patch
	 eapply "${FILESDIR}"/${MY_PN}-gse-build-meson.patch
         eapply "${FILESDIR}"/${MY_PN}-meson_options.patch
         eapply "${FILESDIR}"/${MY_PN}-gse-meson_options.patch
         eapply_user
}

src_configure() {
	meson_src_configure
}

src_compile() {
        meson_src_compile
}

src_install() {
	meson_src_install

	# Install schemas system-wide
	dodir /usr/share/glib-2.0/schemas
	rm "${ED}/usr/share/glib-2.0/schemas/gschemas.compiled" || die
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

