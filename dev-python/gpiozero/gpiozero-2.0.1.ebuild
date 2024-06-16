# Copyright 2024 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A library for controlling the Raspberry Pi's GPIO pins"
HOMEPAGE="https://github.com/gpiozero"
SRC_URI="https://codeload.github.com/${PN}/${PN}/tar.gz/refs/tags/v${PV} -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

DEPEND="${PYTHON_DEPS}"
BDEPEND="${DISTUTILS_DEPS}"

distutils_enable_tests pytest
distutils_enable_sphinx docs
