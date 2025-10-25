# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils

MY_PN="${PN/gnome-shell-extension-/}"

DESCRIPTION="Shutdown Timer for Gnome Shell"
HOMEPAGE="https://github.com/Deminder/ShutdownTimer"
SRC_URI="https://github.com/Deminder/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-SA-4.0 GPL-2.0-or-later GPL-3.0-or-later LGPL-2.0-or-later MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

COMMON_DEPEND="dev-libs/glib:2"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-45
"
DEPEND="${COMMON_DEPEND}"
BDEPEND="
	sys-devel/gettext
"

S="${WORKDIR}/ShutdownTimer-${PV}"
extension_uuid="ShutdownTimer@deminder"
extension="usr/share/gnome-shell/extensions/"${extension_uuid}""

src_prepare() {
	default
	# Fix locale directory location for translations to work
	sed -i 's/..\/locale/..\/..\/..\/..\/locale/g' src/tool/installer.sh || die
}

src_compile() {
	emake translations
 }

src_install() {
	einstalldocs
	insinto /usr/share/glib-2.0/schemas
	doins src/schemas/*.xml
	rm -rf src/schemas || die
	insinto /usr/share/locale
	doins -r src/locale/*
	rm -rf src/locale || die
	insinto /"${extension}"
	doins -r src/*
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	chmod a+x /"${extension}"/tool/installer.sh || die
	gnome2_schemas_update
	ebegin "Updating list of installed extensions"
	eselect gnome-shell-extensions update
	eend $?	
}

pkg_postrm() {
	gnome2_schemas_update
}
