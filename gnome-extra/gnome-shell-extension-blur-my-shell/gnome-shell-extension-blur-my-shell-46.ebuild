# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils

MY_PN="${PN/gnome-shell-extension-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A GNOME Shell extension that adds a blur look to different parts of the GNOME Shell, including the top panel, dash and overview."
HOMEPAGE="https://github.com/aunetx/blur-my-shell"
SRC_URI="https://github.com/aunetx/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="dev-libs/glib:2"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-3.36
"
DEPEND="${COMMON_DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_P}"
extensions=.local/share/gnome-shell/extensions
extension_uuid="blur-my-shell@aunetx"

# Not useful for us
src_compile() { :; }

src_install() {
	default
	cd ${HOME}/${extensions}/"${extension_uuid}"
	insinto /usr/share/gnome-shell/extensions/"${extension_uuid}"
	doins -r *
	insinto /usr/share/glib-2.0/schemas
	doins schemas/*.xml
	insinto /usr/share/locale
	doins -r locale/*
	cd ${S}/
	rm -r ${HOME}/.local ${HOME}/.cache || die
	rm -r ${ED}/usr/share/gnome-shell/extensions/"${extension_uuid}"/locale || die
	rm -r ${ED}/usr/share/gnome-shell/extensions/"${extension_uuid}"/schemas || die
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


