# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ab_glyph_rasterizer@0.1.8
	addr2line@0.19.0
	adler@1.0.2
	ahash@0.7.6
	aho-corasick@0.7.20
	andrew@0.3.1
	android_glue@0.2.3
	anstream@0.2.6
	anstyle-parse@0.1.1
	anstyle-wincon@0.2.0
	anstyle@0.3.5
	async-trait@0.1.68
	autocfg@1.1.0
	backtrace@0.3.67
	base64@0.13.1
	bindgen@0.65.1
	bitflags@1.3.2
	bitflags@2.3.3
	block@0.1.6
	bumpalo@3.12.0
	bytemuck@1.13.1
	byteorder@1.4.3
	bytes@0.4.12
	bytes@1.4.0
	calloop@0.6.5
	cc@1.0.79
	cexpr@0.6.0
	cfg-if@0.1.10
	cfg-if@1.0.0
	cgl@0.3.2
	clang-sys@1.6.1
	clap@4.2.1
	clap_builder@4.2.1
	clap_derive@4.2.0
	clap_lex@0.4.1
	clipboard-win@3.1.1
	cocoa-foundation@0.1.1
	cocoa@0.24.1
	color_quant@1.1.0
	concolor-override@1.0.0
	concolor-query@0.3.3
	copypasta@0.8.2
	core-foundation-sys@0.7.0
	core-foundation-sys@0.8.4
	core-foundation@0.7.0
	core-foundation@0.9.3
	core-graphics-types@0.1.1
	core-graphics@0.19.2
	core-graphics@0.22.3
	core-video-sys@0.1.4
	crc32fast@1.3.2
	crossbeam-channel@0.5.7
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.14
	crossbeam-queue@0.3.8
	crossbeam-utils@0.8.15
	crossbeam@0.8.2
	csscolorparser@0.6.2
	cty@0.2.2
	darling@0.10.2
	darling_core@0.10.2
	darling_macro@0.10.2
	derive-new@0.5.9
	difflib@0.4.0
	dirs-sys@0.3.7
	dirs@4.0.0
	dispatch@0.2.0
	dlib@0.4.2
	dlib@0.5.0
	downcast-rs@1.2.0
	downcast@0.11.0
	either@1.8.1
	equivalent@1.0.1
	errno-dragonfly@0.1.2
	errno@0.3.1
	euclid@0.22.9
	filetime@0.2.21
	flate2@1.0.25
	flexi_logger@0.22.6
	float-cmp@0.9.0
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.1.0
	fragile@2.0.0
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-executor@0.3.28
	futures-io@0.3.28
	futures-macro@0.3.28
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	futures@0.1.31
	futures@0.3.28
	gethostname@0.2.3
	getrandom@0.1.16
	getrandom@0.2.9
	gimli@0.27.2
	gl@0.14.0
	gl_generator@0.14.0
	glob@0.3.1
	hashbrown@0.12.3
	hashbrown@0.14.0
	heck@0.4.1
	hermit-abi@0.2.6
	hermit-abi@0.3.1
	ident_case@1.0.1
	idna@0.3.0
	image@0.24.6
	indexmap@2.0.0
	instant@0.1.12
	io-lifetimes@1.0.10
	iovec@0.1.4
	is-terminal@0.4.7
	itertools@0.10.5
	itoa@1.0.6
	jni-sys@0.3.0
	js-sys@0.3.61
	khronos_api@3.1.0
	lazy-bytes-cast@5.0.1
	lazy_static@1.4.0
	lazycell@1.3.0
	libc@0.2.141
	libloading@0.6.7
	libloading@0.7.4
	linux-raw-sys@0.3.1
	lock_api@0.4.9
	log@0.4.17
	lru@0.7.8
	malloc_buf@0.0.6
	memchr@2.5.0
	memmap2@0.1.0
	memmap2@0.2.3
	memmap2@0.5.10
	memoffset@0.6.5
	memoffset@0.8.0
	minimal-lexical@0.2.1
	miniz_oxide@0.6.2
	mio-misc@1.2.2
	mio@0.7.14
	mio@0.8.6
	miow@0.3.7
	mockall@0.11.4
	mockall_derive@0.11.4
	nameof@1.2.2
	ndk-glue@0.3.0
	ndk-macro@0.2.0
	ndk-sys@0.2.2
	ndk@0.3.0
	nix@0.18.0
	nix@0.20.0
	nix@0.24.3
	nom@7.1.3
	normalize-line-endings@0.3.0
	ntapi@0.3.7
	num-integer@0.1.45
	num-rational@0.4.1
	num-traits@0.2.15
	num_cpus@1.15.0
	num_enum@0.5.11
	num_enum_derive@0.5.11
	num_threads@0.1.6
	nvim-rs@0.5.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	object@0.30.3
	once_cell@1.17.1
	osmesa-sys@0.1.2
	owned_ttf_parser@0.15.2
	parity-tokio-ipc@0.9.0
	parking_lot@0.11.2
	parking_lot@0.12.1
	parking_lot_core@0.8.6
	parking_lot_core@0.9.7
	paste@1.0.12
	peeking_take_while@0.1.2
	percent-encoding@2.2.0
	phf@0.11.1
	phf_generator@0.11.1
	phf_macros@0.11.1
	phf_shared@0.11.1
	pin-project-internal@1.0.12
	pin-project-lite@0.2.9
	pin-project@1.0.12
	pin-utils@0.1.0
	pkg-config@0.3.26
	png@0.17.7
	ppv-lite86@0.2.17
	predicates-core@1.0.6
	predicates-tree@1.0.9
	predicates@2.1.5
	prettyplease@0.2.12
	proc-macro-crate@0.1.5
	proc-macro-crate@1.3.1
	proc-macro2@1.0.66
	quote@1.0.32
	rand@0.7.3
	rand@0.8.5
	rand_chacha@0.2.2
	rand_chacha@0.3.1
	rand_core@0.5.1
	rand_core@0.6.4
	rand_hc@0.2.0
	raw-window-handle@0.3.4
	raw-window-handle@0.4.3
	redox_syscall@0.2.16
	redox_users@0.4.3
	regex-syntax@0.6.29
	regex@1.7.3
	ring@0.16.20
	rmp@0.8.11
	rmpv@1.0.0
	rustc-demangle@0.1.22
	rustc-hash@1.1.0
	rustix@0.37.11
	rustls@0.20.8
	rusttype@0.9.3
	rustversion@1.0.12
	ryu@1.0.13
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.1.0
	sct@0.7.0
	serde@1.0.159
	serde_derive@1.0.159
	serde_json@1.0.95
	serde_spanned@0.6.3
	shared_library@0.1.9
	shlex@1.1.0
	signal-hook-registry@1.4.1
	siphasher@0.3.10
	skia-bindings@0.62.0
	skia-safe@0.62.0
	slab@0.4.8
	smallvec@1.10.0
	smithay-client-toolkit@0.12.3
	smithay-client-toolkit@0.16.0
	smithay-clipboard@0.6.6
	socket2@0.4.9
	spin@0.5.2
	strsim@0.10.0
	strsim@0.9.3
	swash@0.1.6
	syn@1.0.109
	syn@2.0.27
	tar@0.4.38
	termtree@0.4.1
	thiserror-impl@1.0.40
	thiserror@1.0.40
	time-macros@0.2.4
	time@0.3.9
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-io@0.1.13
	tokio-macros@2.0.0
	tokio-util@0.7.7
	tokio@1.27.0
	toml@0.5.11
	toml@0.7.6
	toml_datetime@0.6.3
	toml_edit@0.19.14
	ttf-parser@0.15.2
	unicode-bidi@0.3.13
	unicode-ident@1.0.8
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	untrusted@0.7.1
	ureq@2.6.2
	url@2.3.1
	utf8parse@0.2.1
	version_check@0.9.4
	walkdir@2.3.3
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.9.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.84
	wasm-bindgen-macro-support@0.2.84
	wasm-bindgen-macro@0.2.84
	wasm-bindgen-shared@0.2.84
	wasm-bindgen@0.2.84
	wayland-client@0.28.6
	wayland-client@0.29.5
	wayland-commons@0.28.6
	wayland-commons@0.29.5
	wayland-cursor@0.28.6
	wayland-cursor@0.29.5
	wayland-egl@0.28.6
	wayland-protocols@0.28.6
	wayland-protocols@0.29.5
	wayland-scanner@0.28.6
	wayland-scanner@0.29.5
	wayland-sys@0.28.6
	wayland-sys@0.29.5
	web-sys@0.3.61
	webpki-roots@0.22.6
	webpki@0.22.0
	which@4.4.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-wsapoll@0.1.1
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-targets@0.42.2
	windows-targets@0.48.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.0
	winnow@0.5.2
	winres@0.1.12
	x11-clipboard@0.7.1
	x11-dl@2.21.0
	x11rb-protocol@0.10.0
	x11rb@0.10.1
	xattr@0.2.3
	xcursor@0.3.4
	xdg@2.4.1
	xml-rs@0.8.4
	yazi@0.1.4
	zeno@0.2.2
"

declare -A GIT_CRATES=(
	[glutin]='https://github.com/neovide/glutin;7c313d91584492961b9efab0d611e35b977c0fea;glutin-%commit%/glutin'
	[glutin_egl_sys]='https://github.com/neovide/glutin;7c313d91584492961b9efab0d611e35b977c0fea;glutin-%commit%/glutin_egl_sys'
	[glutin_emscripten_sys]='https://github.com/neovide/glutin;7c313d91584492961b9efab0d611e35b977c0fea;glutin-%commit%/glutin_emscripten_sys'
	[glutin_gles2_sys]='https://github.com/neovide/glutin;7c313d91584492961b9efab0d611e35b977c0fea;glutin-%commit%/glutin_gles2_sys'
	[glutin_glx_sys]='https://github.com/neovide/glutin;7c313d91584492961b9efab0d611e35b977c0fea;glutin-%commit%/glutin_glx_sys'
	[glutin_wgl_sys]='https://github.com/neovide/glutin;7c313d91584492961b9efab0d611e35b977c0fea;glutin-%commit%/glutin_wgl_sys'
	[winit]='https://github.com/neovide/winit;27967af60d408218529255e897964b6cffd94659;winit-%commit%'
	[xkbcommon-dl]='https://github.com/maroider/xkbcommon-dl;900832888ad6f11011d1369befb344a9aa8a9610;xkbcommon-dl-%commit%'
)

PYTHON_COMPAT=( python3_{9..12} )

inherit cargo desktop python-any-r1 xdg-utils

DESCRIPTION="Neovide: A No Nonsense Neovim Gui"
HOMEPAGE="https://neovide.dev"

if [ ${PV} == "9999" ]; then
	SRC_URI="
		https://codeload.github.com/rust-skia/skia/tar.gz/m113-0.61.8 -> skia.tar.gz
		https://codeload.github.com/rust-skia/depot_tools/tar.gz/73a2624 -> depot_tools.tar.gz
		https://codeload.github.com/google/wuffs-mirror-release-c/tar.gz/e3f919c -> wuffs.tar.gz
	"

	inherit git-r3
	EGIT_REPO_URI="https://github.com/neovide/neovide"
else
	SRC_URI="
		https://codeload.github.com/neovide/neovide/tar.gz/refs/tags/0.10.4 -> ${P}.tar.gz
		https://codeload.github.com/rust-skia/skia/tar.gz/m113-0.61.8 -> skia.tar.gz
		https://codeload.github.com/rust-skia/depot_tools/tar.gz/73a2624 -> depot_tools.tar.gz
		https://codeload.github.com/google/wuffs-mirror-release-c/tar.gz/e3f919c -> wuffs.tar.gz
		$(cargo_crate_uris)
	"
	KEYWORDS="~amd64"
fi

LICENSE="
	Apache-1.0 Apache-2.0 BSD Boost-1.0 CC0-1.0 ISC LGPL-3 MIT MPL-2.0
	SSLeay Unicode-DFS-2016 
"
SLOT="0"
IUSE="wayland lunarvim +X test"

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
	>=virtual/rust-1.57.0
	sys-devel/clang
	dev-util/gn
	dev-util/ninja
	virtual/pkgconfig
"

# Cargo strips the final neovide binary. We don't need portage to tell us about it.
QA_PRESTRIPPED="usr/bin/neovide"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		eapply "${FILESDIR}/00_${PN}-skia-bindings-0.62.0.patch"
		cargo_live_src_unpack
		unpack ${A}
	else
		cargo_src_unpack
		unpack ${A}
		eapply "${FILESDIR}/00_${P}-skia-bindings-0.62.0.patch"
	fi

	my_skia="skia-m113-0.61.8"
	my_depot="depot_tools-73a2624"
	my_wuffs="wuffs-mirror-release-c-e3f919c"

	if [[ "${PV}" == *9999* ]]; then
		my_lskia="${CARGO_HOME}/gentoo/skia-bindings/skia"
		my_ldepot="${CARGO_HOME}/gentoo/skia-bindings/depot_tools"
	else
		my_lskia="${CARGO_HOME}/gentoo/skia-bindings-0.62.0/skia"
		my_ldepot="${CARGO_HOME}/gentoo/skia-bindings-0.62.0/depot_tools"
	fi

	my_externals="${my_lskia}/third_party/externals"
	mv "${WORKDIR}/${my_skia}" "${my_lskia}"
	mv "${WORKDIR}/${my_depot}" "${my_ldepot}"
	mkdir "${my_externals}"
	mv "${WORKDIR}/${my_wuffs}" "${my_externals}/wuffs"

	# The patches work for 9999 and versioned ebuilds. Change the build directory
	# name so that the patches can apply to them.
	mv "${S}" "${WORKDIR}/${PN}"
	S="${WORKDIR}/${PN}"

	# A few system lib don't like to get linked. We're adding code to the build.rs
	# to ensure the CC command knows where these system libs are.
	eapply "${FILESDIR}/01_neovide-include-libs.patch"
}

src_configure() {
	cargo_src_configure
}

src_compile() {
	# Skia-bindings + Skia-safe need these set to build. The depot_tools don't seem
	# to work correctly in an ebuild environment.
	# - To generate the bindings, we need to build skia... Yuck.
	export CLANGCC=clang
	export CLANGCXX=clang++
	export SKIA_SOURCE_DIR="${my_lskia}"
	export SKIA_USE_SYSTEM_LIBRARIES=true
	export SKIA_NINJA_COMMAND=/usr/bin/ninja
	export SKIA_GN_COMMAND=/usr/bin/gn
	export BINDGEN_EXTRA_CLANG_ARGS=--target=x86_64-pc-linux-gnu

	if [ "${PV}" == "*9999*" ]; then
		cargo_src_compile --frozen --features embed-fonts
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
	doicon assets/${PN}.svg

	if use lunarvim; then
		domenu ${FILESDIR}/neovide-lunarvim.desktop
		dobin ${FILESDIR}/neovide-lunarvim
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
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
