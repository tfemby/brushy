# Copyright 2024 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="tk"
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517="setuptools"

inherit desktop distutils-r1 xdg-utils

DESCRIPTION="A Python IDE for beginners"
HOMEPAGE="https://thonny.org https://github.com/thonny/thonny"
SRC_URI="https://codeload.github.com/${PN}/${PN}/tar.gz/refs/tags/v${PV} -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="crypt dbus ssh esptool"

DEPEND="${PYTHON_DEPS}"
RDEPEND="
	dev-python/jedi
	dev-python/pyserial
	dev-python/pylint
	dev-python/isort
	dev-python/mccabe
	dev-python/docutils
	dev-python/mypy
	dev-python/asttokens
	dev-python/send2trash
	dev-python/websockets
	dev-python/ptyprocess
	crypt? (
		dev-python/bcrypt
		dev-python/cryptography
	)
	dbus? ( dev-python/dbus-next )
	esptool? ( dev-embedded/esptool )
	ssh? ( dev-python/paramiko )
"
BDEPEND="
	${RDEPEND}
	${DISTUTILS_DEPS}
	dev-python/flit-core
	dev-python/packaging
"

distutils_enable_tests pytest

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	distutils-r1_python_install_all

	local i
	for i in 16x16 22x22 32x32 48x48 64x64 128x128 192x192 256x256; do
		newicon -s "${i}" packaging/icons/"${PN}"-"${i}".png "${PN}".png
	done

	domenu packaging/linux/org.thonny.Thonny.desktop
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update

	einfo ""
	einfo "If you want to experiment with micropython, you"
	einfo "will likely want to install dev-lang/micropython"
	einfo "from this overlay."
	einfo ""
	einfo "You can configure to use micropython from within"
	einfo "thonny: tools -> interpreter -> MicroPython (local)"
	einfo ""
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
