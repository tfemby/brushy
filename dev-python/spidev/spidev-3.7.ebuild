# Copyright 2024 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for Linux SPI access through spidev"
HOMEPAGE="https://github.com/doceme/py-spidev https://pypi.org/project/spidev/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64"

distutils_enable_tests pytest
