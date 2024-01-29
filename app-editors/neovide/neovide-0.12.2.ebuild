# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=" "

PYTHON_COMPAT=( python3_{9..12} )

inherit cargo desktop python-any-r1 xdg-utils

DESCRIPTION="Neovide: A No Nonsense Neovim Gui"
HOMEPAGE="https://neovide.dev"
SKIA_VERSION="0.68.0"

if [[ ${PV} == "9999" ]]; then
	SRC_URI="
		https://github.com/rust-skia/skia-binaries/releases/download/${SKIA_VERSION}/skia-binaries-f0bea3ad919500904bb9-x86_64-unknown-linux-gnu-egl-gl-svg-textlayout-wayland-x11.tar.gz  -> skia-binaries-${SKIA_VERSION}.tar.gz
	"
	inherit git-r3
	EGIT_REPO_URI="https://github.com/neovide/neovide"
else
	SRC_URI="
		https://codeload.github.com/neovide/neovide/tar.gz/refs/tags/${PV} -> ${P}.tar.gz
		https://github.com/tfemby/brushy/releases/download/neovide-0.12.2-vendored/vendor.tar.xz -> ${P}-vendor.tar.xz
		https://github.com/rust-skia/skia-binaries/releases/download/${SKIA_VERSION}/skia-binaries-f0bea3ad919500904bb9-x86_64-unknown-linux-gnu-egl-gl-svg-textlayout-wayland-x11.tar.gz  -> skia-binaries-${SKIA_VERSION}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="
	Apache-1.0 Apache-2.0 BSD Boost-1.0 CC0-1.0 ISC LGPL-3 MIT MPL-2.0
	OFL-1.1 SSLeay Unicode-DFS-2016
"
SLOT="0"
IUSE="lunarvim wayland +X"

REQUIRED_USE="|| ( wayland X )"

COMMON_DEPEND="
	app-arch/bzip2
	app-crypt/gnupg
	app-misc/ca-certificates
	dev-libs/expat
	dev-util/pkgconf
	dev-vcs/git
	media-libs/alsa-lib
	media-libs/fontconfig:=
	media-libs/freetype
	media-libs/freeglut
	sys-libs/zlib
"

DEPEND="
	${COMMON_DEPEND}
	${PYTHON_DEPS}
"

RDEPEND="
	${COMMON_DEPEND}
	app-editors/neovim
	media-libs/mesa[X?,wayland?]
	wayland? ( dev-libs/wayland )
	X? (
		x11-libs/libX11
		x11-libs/libxcb
		x11-libs/libXcursor
		x11-libs/libXi
		x11-libs/libXmu
	)
"

BDEPEND="
	${COMMON_DEPEND}
	dev-util/cmake
	virtual/rust
"

# Cargo strips the final neovide binary (default functionality of a --release build).
QA_PRESTRIPPED="usr/bin/neovide"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi

	# Change builddir so our lib patch works.
	mv "${S}" "${WORKDIR}/${PN}"
	S="${WORKDIR}/${PN}"

	# A few system lib don't get linked. We're adding ld args in build.rs.
	eapply "${FILESDIR}/01_neovide-include-libs.patch"

	# Necessary in order to use the vendored sources
	ln -s "${WORKDIR}/brushy/vendor/"* "${CARGO_HOME}/gentoo/" || die
#	sed -i "${ECARGO_HOME}/config" -e '/source.crates-io/d' || die
#	sed -i "${ECARGO_HOME}/config" -e '/replace-with = "gentoo"/d' || die
#	sed -i "${ECARGO_HOME}/config" -e '/local-registry = "\/nonexistent"/d' || die
}

src_configure() {
	cargo_src_configure
}

src_compile() {
	# The skia-bindings binary_cache feature requires us to point to the .tar.gz
	export SKIA_BINARIES_URL="file://${DISTDIR}/skia-binaries-${SKIA_VERSION}.tar.gz"
	export CARGO_PROFILE_RELEASE_BUILD_OVERRIDE_DEBUG=true
	export RUST_BACKTRACE=full

	if [ "${PV}" == "*9999*" ]; then
		cargo_src_compile --frozen --features embed-fonts --config 'SKIA_BINARIES_URL="file://${DISTDIR}/skia-binaries-${SKIA_VERSION}.tar.gz"'
	else
		cargo_src_compile --features embed-fonts
	fi
}

src_install() {
	cargo_src_install

	domenu assets/neovide.desktop

	local i
	for i in 16x16 32x32 48x48 256x256; do
		newicon -s "${i}" assets/"${PN}"-"${i}".png "${PN}".png
	done
	doicon assets/"${PN}".svg

	if use lunarvim; then
		domenu "${FILESDIR}"/neovide-lunarvim.desktop
		dobin "${FILESDIR}"/neovide-lunarvim
	fi
}

src_test() {
	cd "${PN}" || die
	cargo_src_test
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update

	einfo ""
	einfo "Neovide provides some functionality that may be enabled in your"
	einfo "init.lua or init.vim. Visit the following for more info."
	einfo "https://neovide.dev/configuration.html"
	einfo ""
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
