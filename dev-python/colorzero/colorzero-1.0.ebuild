# Copyright 2024 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A color manipulation library for Python"
HOMEPAGE="https://github.com/waveform80/colorzero"
SRC_URI="https://codeload.github.com/waveform80/${PN}/tar.gz/refs/tags/release-${PV} -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-release-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

DEPEND="${PYTHON_DEPS}"
BDEPEND="${DISTUTILS_DEPS}"

distutils_enable_tests pytest
distutils_enable_sphinx docs
