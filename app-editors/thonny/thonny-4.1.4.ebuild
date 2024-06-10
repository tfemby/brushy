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
IUSE="crypt dbus esptool science web xlsx"

DEPEND="${PYTHON_DEPS}"
# Base requirements are located in the root file "requirements.txt"
# Extras are located at packaging/requirements-xxl-bundle.txt
RDEPEND="
	dev-python/asttokens
	dev-python/colorama
	dev-python/docutils
	dev-python/isort
	dev-python/jedi
	dev-python/mccabe
	dev-python/mypy
	dev-python/ptyprocess
	dev-python/pyserial
	dev-python/pylint
	dev-python/send2trash
	dev-python/websockets
	crypt? (
		dev-python/bcrypt
		dev-python/cryptography
		dev-python/paramiko
	)
	dbus? ( dev-python/dbus-next )
	esptool? ( dev-embedded/esptool )
	science? (
		dev-python/matplotlib
		dev-python/numpy
		dev-python/scipy
	)
	web? (
		dev-python/flask
		dev-python/html5lib
		dev-python/openpyxl
		dev-python/requests
	)
	xlsx? (
		dev-python/odfpy
		dev-python/xlsxwriter
		dev-python/xlrd
		dev-python/xlwt
	)
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
	einfo "can install dev-lang/micropython"
	einfo ""
	einfo "You can configure to use micropython from within"
	einfo "thonny: tools -> interpreter -> MicroPython (local)"
	einfo ""
	einfo "If you want to make games, you can install"
	einfo "dev-python/pgzero"
	einfo ""
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
