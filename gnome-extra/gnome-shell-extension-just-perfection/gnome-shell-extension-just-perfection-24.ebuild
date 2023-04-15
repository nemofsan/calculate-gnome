# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils

MY_PN="${PN/gnome-shell-extension-/}"
MY_PV="${PV}.0"

DESCRIPTION="Disable GNOME Shell UI Elements, Change the Behavior and Customize your GNOME Shell Desktop."
HOMEPAGE="https://gitlab.gnome.org/jrahmatzadeh/just-perfection"
SRC_URI="https://gitlab.gnome.org/jrahmatzadeh/${MY_PN}/-/archive/${MY_PV}/${MY_PN}-${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	dev-libs/glib:2
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-40.0
"
DEPEND="${COMMON_DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_PN}-${MY_PV}"
extensions=.local/share/gnome-shell/extensions
extension_uuid="just-perfection-desktop@just-perfection"

# Not useful for us
src_compile() { :; }

src_install() {
	einstalldocs
	sh scripts/build.sh -i
	cd ${HOME}/${extensions}/"${extension_uuid}"
	insinto /usr/share/gnome-shell/extensions/"${extension_uuid}"
	doins -r *
	insinto /usr/share/glib-2.0/schemas
	doins schemas/*.xml
	insinto /usr/share/locale
	doins -r locale/*
	cd ${S}/
	rm -r ${HOME}/.local ${HOME}/.cache || die
	cd ${ED}/usr/share/gnome-shell/extensions/"${extension_uuid}"
	rm -r locale/ schemas/ || die
	rm -f CHANGELOG.md LICENSE || die
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

