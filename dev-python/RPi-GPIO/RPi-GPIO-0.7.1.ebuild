# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

MY_PN=${PN/-/.}
DESCRIPTION="A module to control the GPIO on a Raspberry Pi"
HOMEPAGE="https://sourceforge.net/projects/raspberry-gpio-python/ https://pypi.org/project/RPi.GPIO/"
SRC_URI="$(pypi_sdist_url --no-normalize "${MY_PN}" "${PV}" )"

S=${WORKDIR}/${MY_PN}-${PV}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64"

DOCS="README.txt"

DEPEND="${PYTHON_DEPS}"
BDEPEND="${DISTUTILS_DEPS}"
BDEPEND="
		${DEPEND}
		${BDEPEND}
"

distutils_enable_tests pytest
