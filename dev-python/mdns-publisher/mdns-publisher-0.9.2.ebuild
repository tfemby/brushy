# Copyright 2024 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Publish CNAMEs pointing to the local host over Avahi/mDNS"
HOMEPAGE="https://github.com/carlosefr/mdns-publisher https://pypi.org/projects/mdns-publisher"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}" )"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64"

DEPEND="${PYTHON_DEPS}"
# Base requirements are located in the root file "requirements.txt"
# Extras are located at packaging/requirements-xxl-bundle.txt
RDEPEND="
	dev-libs/dbus-glib
	dev-python/dbus-python

"
BDEPEND="
	${RDEPEND}
	${DISTUTILS_DEPS}
"

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	distutils-r1_python_install_all

	newinitd "${FILESDIR}"/mdns-publish-cname.initd mdns-publish-cname
	newconfd "${FILESDIR}"/mdns-publish-cname.confd mdns-publish-cname
}

distutils_enable_tests pytest
