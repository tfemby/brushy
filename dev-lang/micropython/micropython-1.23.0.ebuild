# Copyright 1999-2024 Gentoo Creators & Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Python implementation for microcontrollers"
HOMEPAGE="https://github.com/micropython/micropython"

# Pull in the release via git commit. We're doing this for submodules anyways.
MICROPYTHON_COMMIT_SHA="a61c446c0b34e82aeb54b9770250d267656f2b7f"

# Submodules commit SHA's
BERKELEY_DB_1_COMMIT_SHA="85373b548f1fb0119a463582570b44189dfb09ae"
MBEDTLS_COMMIT_SHA="edb8fec9882084344a314368ac7fd957a187519c"
MICROPYTHON_LIB_COMMIT_SHA="50ed36fbeb919753bcc26ce13a8cffd7691d06ef"

# Update instructions:
#	1. Pull in the release via git. e.g. `git pull --single-branch -b v1.23.0 git@github.com:micropython/micropython.git`
# 	2. Unpack and go to micropython/ports/unix
# 	3. Run `make submodules`
# 	4. Record the sha's pulled in and replace above.
# 	5. Alternatively, go to release page, browse the 'lib' dir and copy+paste the submodule commit.
SRC_URI="
	https://codeload.github.com/${PN}/${PN}/tar.gz/${MICROPYTHON_COMMIT_SHA} \
		-> ${P}.tar.gz
	https://codeload.github.com/${PN}/berkeley-db-1.xx/tar.gz/${BERKELEY_DB_1_COMMIT_SHA} \
		-> ${P}-lib_berkeley-db-1.xx.tar.gz
	https://codeload.github.com/Mbed-TLS/mbedtls/tar.gz/${MBEDTLS_COMMIT_SHA} \
		-> ${P}-lib_mbedtls.tar.gz
	https://codeload.github.com/${PN}/micropython-lib/tar.gz/${MICROPYTHON_LIB_COMMIT_SHA} \
		-> ${P}-lib_micropython-lib.tar.gz
"

S="${WORKDIR}/${PN}-${MICROPYTHON_COMMIT_SHA}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/libffi:=
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${P}-gcc13-build-fix.patch"
)
#	"${FILESDIR}/${P}-prevent-stripping.patch"
#	"${FILESDIR}/${P}-exclude-float-parse-tests.patch"

src_unpack() {
	unpack "${P}.tar.gz"

	# Manually unpack submodules
	# REFERENCE: https://forums.gentoo.org/viewtopic-t-1151687.html
	cd "${S}" || die

	local i list=(
		lib_berkeley-db-1.xx
		lib_mbedtls
		lib_micropython-lib
	)

	for i in "${list[@]}"; do
		tar xf "${DISTDIR}/${P}-${i}.tar.gz" --strip-components 1 -C "${i//_//}" \
			|| die "Failed to unpack ${P}-${i}.tar.gz"
	done
}

src_prepare() {
	default

	cd ports/unix || die

	# 1) don't die on compiler warning
	# 2) remove /usr/local prefix references in favour of /usr
	# 3) enforce our CFLAGS
	# 4) enforce our LDFLAGS
	sed -e 's#-Werror##g;' \
		-e 's#\/usr\/local#\/usr#g;' \
		-e "s#^CFLAGS = \(.*\)#CFLAGS = \1 ${CFLAGS}#g" \
		-e "s#^LDFLAGS = \(.*\)#LDFLAGS = \1 ${LDFLAGS}#g" \
		-i Makefile || die "can't patch Makefile"
}

src_compile() {
	# Build the cross-compiler first. Unix port build fails without this.
	einfo ""
	einfo "Building the mpy-crosscompiler."
	einfo ""
	cd "${S}/mpy-cross" || die
	emake CC="$(tc-getCC)"

	# Finally, build the unix port.
	einfo ""
	einfo "Building the micropython unix port."
	einfo ""
	cd "${S}/ports/unix" || die
	emake CC="$(tc-getCC)"
}

src_test() {
	cd ports/unix || die
	emake CC="$(tc-getCC)" test
}

src_install() {
	pushd ports/unix > /dev/null || die
	emake CC="$(tc-getCC)" DESTDIR="${D}" install
	popd > /dev/null || die

	# remove .git files
	find tools -type f -name '.git*' -exec rm {} \; || die

	dodoc -r tools
	einstalldocs
}
