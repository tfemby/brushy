# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="An emoji selector plugin for Rofi"
HOMEPAGE="https://github.comf/Mange/rofi-emoji"
SRC_URI="https://codeload.github.com/Mange/${PN}/tar.gz/refs/tags/v${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland"

RDEPEND="
	|| ( x11-misc/rofi gui-apps/rofi-wayland )
"

DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf
}
