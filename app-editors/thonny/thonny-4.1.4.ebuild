# Copyright 2024 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="tk"
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517="setuptools"
DISTUTILS_EXT=1

inherit distutils-r1

DESCRIPTION="A Python IDE for beginners"
HOMEPAGE="https://thonny.org"
SRC_URI="https://codeload.github.com/${PN}/${PN}/tar.gz/refs/tags/v${PV} -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	${PYTHON_DEPS}
	${DISTUTILS_DEPS}
	dev-python/pyserial
	dev-python/jedi
	dev-python/pylint
	dev-python/asttokens
	dev-python/send2trash
	dev-python/packaging
"
BDEPEND="${RDEPEND}"

distutils_enable_tests pytest
