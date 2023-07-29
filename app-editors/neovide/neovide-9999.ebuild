# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..12} )

inherit cargo desktop python-any-r1

DESCRIPTION="Neovide: A No Nonsense Neovim Gui"
HOMEPAGE="https://neovide.dev"

SRC_URI="
	https://codeload.github.com/rust-skia/skia/tar.gz/m113-0.61.8 -> skia.tar.gz
	https://codeload.github.com/rust-skia/depot_tools/tar.gz/73a2624 -> depot_tools.tar.gz
	https://codeload.github.com/google/wuffs-mirror-release-c/tar.gz/e3f919c -> wuffs.tar.gz
"

inherit git-r3
EGIT_REPO_URI="https://github.com/neovide/neovide"

LICENSE=""

# Dependent crate licenses
LICENSE+="
		Apache-1.0 Apache-2.0 BSD Boost-1.0 CC0-1.0 ISC LGPL-3 MIT MPL-2.0
		SSLeay Unicode-DFS-2016 
"
SLOT="0"
IUSE="wayland +X"

REQUIRED_USE="|| ( wayland X )"

DEPEND="
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
	media-sound/sndio
	sys-libs/zlib
"

RDEPEND="
	${DEPEND}
	media-libs/mesa[X?,wayland?]
	wayland? ( dev-libs/wayland )
	X? (
		x11-libs/libX11
		x11-lib/libxcb
		x11-libs/libXcursor
		x11-libs/libXi
		x11-libs/libXmu
	)
"

BDEPEND="
		${DEPEND}
		dev-util/cmake
		>=virtual/rust-1.57.0
		sys-devel/clang
		dev-utils/gn
		dev-utils/ninja
"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack

		# The patches work for 9999 and versioned ebuilds
		mv "${S}" "${WORKDIR}/${PN}"
		S="${WORKDIR}/${PN}"

		# Skia-bindings-0.52.0 causes issues in offline build mode. 0.62.0 works better.
		# We're patching early here so the vendor pulls in the correct version.
		eapply "${FILESDIR}/00_${PN}-skia-bindings-0.62.0.patch"

		cargo_live_src_unpack

		# Skia bindings requires us to put the git submodules into the crate manually.
		unpack ${A}

		# This should satisfy all of the skia-related dependencies.
		my_skia="skia-m113-0.61.8"
		my_depot="depot_tools-73a2624"
		my_wuffs="wuffs-mirror-release-c-e3f919c"
		my_externals="${CARGO_HOME}/gentoo/skia-bindings/skia/third_party/externals"

		mv "${WORKDIR}/${my_skia}" "${CARGO_HOME}/gentoo/skia-bindings/skia"
		mv "${WORKDIR}/${my_depot}" "${CARGO_HOME}/gentoo/skia-bindings/depot_tools"
		mkdir "${my_externals}"
		mv "${WORKDIR}/${my_wuffs}" "${my_externals}/wuffs"
	else
		cargo_src_unpack
	fi
}

src_configure() {
		# A few system lib don't like to get linked. We're adding code to the build.rs
		# to ensure the CC command knows where these system libs are.
		eapply "${FILESDIR}/01_${PN}-include-libs.patch"

		python_setup
		cargo_src_configure
}

src_compile() {
		# Skia-bindings + Skia-safe need these set to build. The depot_tools don't seem
		# to work correctly in an ebuild environment.
		# - To generate the bindings, we need to build skia... Yuck.
		export CLANGCC=clang
		export CLANGCXX=clang++
		export SKIA_SOURCE_DIR="${CARGO_HOME}/gentoo/skia-bindings/skia"
		export SKIA_USE_SYSTEM_LIBRARIES=true
		export SKIA_NINJA_COMMAND=/usr/bin/ninja
		export SKIA_GN_COMMAND=/usr/bin/gn
		export BINDGEN_EXTRA_CLANG_ARGS=--target=x86_64-pc-linux-gnu

		cargo_src_compile --frozen --features embed-fonts
}

src_install() {
	cargo_src_install

	domenu assets/neovide.desktop

	local i
	for i in 16x16 32x32 48x48 256x256; do
		newicon -s "${i}" assets/"${PN}"-"${i}".png "${PN}".png
	done
	doicon assets/${PN}.svg

}

src_test() {
	cd "${PN}" || die
	cargo_src_test
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
