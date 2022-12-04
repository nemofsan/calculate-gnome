# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils

COMMIT="a9c046d66aeaa142ff7e9382001bfc6a004b1dbb"

DESCRIPTION="New and maximized windows will be moved to empty workspaces.Supports multiple monitors"
HOMEPAGE="https://github.com/kaiseracm/gnome-shell-extension-maximize-to-empty-workspace"
SRC_URI="https://github.com/kaiseracm/gnome-shell-extension-maximize-to-empty-workspace/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-3.38
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}/${PN}-${COMMIT}"
extension_uuid="MaximizeToEmptyWorkspace-extension@kaisersite.de"

src_compile() { :; }

src_install() {
	einstalldocs
	insinto /usr/share/gnome-shell/extensions/
	doins -r "${extension_uuid}"
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
