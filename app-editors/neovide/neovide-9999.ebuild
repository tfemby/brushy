# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ab_glyph@0.2.21
	ab_glyph_rasterizer@0.1.8
	addr2line@0.20.0
	adler@1.0.2
	ahash@0.7.6
	aho-corasick@1.0.2
	android-activity@0.4.2
	android-properties@0.2.2
	anstream@0.3.2
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	anstyle@1.0.1
	arrayref@0.3.7
	arrayvec@0.7.4
	async-trait@0.1.71
	atomic-waker@1.1.1
	autocfg@1.1.0
	backtrace@0.3.68
	base64@0.21.2
	bindgen@0.65.1
	bitflags@1.3.2
	bitflags@2.3.3
	block-sys@0.1.0-beta.1
	block2@0.2.0-alpha.6
	block@0.1.6
	bumpalo@3.13.0
	bytemuck@1.13.1
	byteorder@1.4.3
	bytes@0.4.12
	bytes@1.4.0
	calloop@0.10.6
	cc@1.0.79
	cexpr@0.6.0
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	cgl@0.3.2
	clang-sys@1.6.1
	clap@4.3.19
	clap_builder@4.3.19
	clap_derive@4.3.12
	clap_lex@0.5.0
	clipboard-win@3.1.1
	cocoa-foundation@0.1.1
	cocoa@0.24.1
	color_quant@1.1.0
	colorchoice@1.0.0
	copypasta@0.8.2
	core-foundation-sys@0.8.4
	core-foundation@0.9.3
	core-graphics-types@0.1.2
	core-graphics@0.22.3
	crc32fast@1.3.2
	csscolorparser@0.6.2
	cursor-icon@1.0.0
	dashmap@5.5.0
	derive-new@0.5.9
	difflib@0.4.0
	dirs-sys@0.4.1
	dirs@5.0.1
	dispatch@0.2.0
	dlib@0.5.2
	downcast-rs@1.2.0
	downcast@0.11.0
	either@1.8.1
	equivalent@1.0.1
	errno-dragonfly@0.1.2
	errno@0.3.1
	euclid@0.22.9
	fdeflate@0.3.0
	filetime@0.2.21
	flate2@1.0.26
	flexi_logger@0.22.6
	float-cmp@0.9.0
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.0
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
	getrandom@0.2.10
	gimli@0.27.3
	gl@0.14.0
	gl_generator@0.14.0
	glob@0.3.1
	glutin-winit@0.4.0-beta.0
	glutin@0.30.9
	glutin_egl_sys@0.5.0
	glutin_glx_sys@0.4.0
	glutin_wgl_sys@0.4.0
	hashbrown@0.12.3
	hashbrown@0.14.0
	heck@0.4.1
	hermit-abi@0.3.2
	home@0.5.5
	idna@0.4.0
	image@0.24.6
	indexmap@2.0.0
	io-lifetimes@1.0.11
	iovec@0.1.4
	is-terminal@0.4.9
	itertools@0.10.5
	itoa@1.0.9
	jni-sys@0.3.0
	jobserver@0.1.26
	js-sys@0.3.64
	khronos_api@3.1.0
	lazy-bytes-cast@5.0.1
	lazy_static@1.4.0
	lazycell@1.3.0
	libc@0.2.147
	libloading@0.7.4
	libloading@0.8.0
	linux-raw-sys@0.4.3
	lock_api@0.4.10
	log@0.4.19
	lru@0.7.8
	malloc_buf@0.0.6
	memchr@2.5.0
	memmap2@0.5.10
	memoffset@0.6.5
	memoffset@0.7.1
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	mio@0.8.8
	mockall@0.11.4
	mockall_derive@0.11.4
	ndk-context@0.1.1
	ndk-sys@0.4.1+23.1.7779620
	ndk@0.7.0
	nix@0.24.3
	nix@0.25.1
	nix@0.26.2
	nom@7.1.3
	normalize-line-endings@0.3.0
	num-integer@0.1.45
	num-rational@0.4.1
	num-traits@0.2.15
	num_cpus@1.16.0
	num_enum@0.5.11
	num_enum@0.6.1
	num_enum_derive@0.5.11
	num_enum_derive@0.6.1
	num_threads@0.1.6
	nvim-rs@0.5.0
	objc-foundation@0.1.1
	objc-sys@0.2.0-beta.2
	objc2-encode@2.0.0-pre.2
	objc2@0.3.0-beta.3.patch-leaks.3
	objc@0.2.7
	objc_id@0.1.1
	object@0.31.1
	once_cell@1.18.0
	option-ext@0.2.0
	orbclient@0.3.45
	owned_ttf_parser@0.19.0
	parity-tokio-ipc@0.9.0
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	paste@1.0.14
	peeking_take_while@0.1.2
	percent-encoding@2.3.0
	phf@0.11.2
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.11.2
	pin-project-internal@1.1.2
	pin-project-lite@0.2.10
	pin-project@1.1.2
	pin-utils@0.1.0
	pkg-config@0.3.27
	png@0.17.9
	ppv-lite86@0.2.17
	predicates-core@1.0.6
	predicates-tree@1.0.9
	predicates@2.1.5
	prettyplease@0.2.10
	proc-macro-crate@1.3.1
	proc-macro2@1.0.66
	quick-xml@0.28.2
	quote@1.0.31
	rand@0.7.3
	rand@0.8.5
	rand_chacha@0.2.2
	rand_chacha@0.3.1
	rand_core@0.5.1
	rand_core@0.6.4
	rand_hc@0.2.0
	raw-window-handle@0.5.2
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_users@0.4.3
	regex-automata@0.3.3
	regex-syntax@0.7.4
	regex@1.9.1
	ring@0.16.20
	rmp@0.8.11
	rmpv@1.0.0
	rustc-demangle@0.1.23
	rustc-hash@1.1.0
	rustix@0.38.4
	rustls-webpki@0.100.1
	rustls-webpki@0.101.1
	rustls@0.21.5
	rustversion@1.0.14
	ryu@1.0.15
	scoped-env@2.1.0
	scoped-tls@1.0.1
	scopeguard@1.1.0
	sct@0.7.0
	sctk-adwaita@0.6.0
	serde@1.0.171
	serde_derive@1.0.171
	serde_json@1.0.103
	serde_spanned@0.6.3
	serial_test@2.0.0
	serial_test_derive@2.0.0
	shlex@1.1.0
	signal-hook-registry@1.4.1
	simd-adler32@0.3.5
	siphasher@0.3.10
	skia-bindings@0.62.0
	skia-safe@0.62.0
	slab@0.4.8
	slotmap@1.0.6
	smallvec@1.11.0
	smithay-client-toolkit@0.16.0
	smithay-client-toolkit@0.17.0
	smithay-clipboard@0.6.6
	smol_str@0.2.0
	socket2@0.4.9
	spin@0.5.2
	static_assertions@1.1.0
	strict-num@0.1.1
	strsim@0.10.0
	swash@0.1.8
	syn@1.0.109
	syn@2.0.26
	tar@0.4.39
	termtree@0.4.1
	thiserror-impl@1.0.43
	thiserror@1.0.43
	time-macros@0.2.4
	time@0.3.9
	tiny-skia-path@0.8.4
	tiny-skia@0.8.4
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-io@0.1.13
	tokio-macros@2.1.0
	tokio-util@0.7.8
	tokio@1.29.1
	toml@0.5.11
	toml@0.7.6
	toml_datetime@0.6.3
	toml_edit@0.19.14
	tracy-client-sys@0.19.0
	ttf-parser@0.19.1
	unicode-bidi@0.3.13
	unicode-ident@1.0.11
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	untrusted@0.7.1
	ureq@2.7.1
	url@2.4.0
	utf8parse@0.2.1
	vec_map@0.8.2
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.9.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-futures@0.4.37
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	wayland-backend@0.1.2
	wayland-client@0.29.5
	wayland-client@0.30.2
	wayland-commons@0.29.5
	wayland-cursor@0.29.5
	wayland-cursor@0.30.0
	wayland-protocols-wlr@0.1.0
	wayland-protocols@0.29.5
	wayland-protocols@0.30.1
	wayland-scanner@0.29.5
	wayland-scanner@0.30.1
	wayland-sys@0.29.5
	wayland-sys@0.30.1
	web-sys@0.3.64
	web-time@0.2.0
	webpki-roots@0.23.1
	which@4.4.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-wsapoll@0.1.1
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-targets@0.42.2
	windows-targets@0.48.1
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
	winit@0.29.0-beta.0
	winnow@0.5.0
	winres@0.1.12
	x11-clipboard@0.7.1
	x11-dl@2.21.0
	x11rb-protocol@0.10.0
	x11rb@0.10.1
	xattr@0.2.3
	xcursor@0.3.4
	xdg@2.5.0
	xkbcommon-dl@0.4.1
	xkeysym@0.2.0
	xml-rs@0.8.15
	yazi@0.1.6
	zeno@0.2.2
"

PYTHON_COMPAT=( python3_{9..12} )

inherit cargo desktop python-any-r1 xdg-utils

DESCRIPTION="Neovide: A No Nonsense Neovim Gui"
HOMEPAGE="https://neovide.dev"

if [[ ${PV} == "9999" ]]; then
	SRC_URI="
		https://github.com/rust-skia/skia-binaries/releases/download/0.62.0/skia-binaries-8cf4841aefdb295709e9-x86_64-unknown-linux-gnu-egl-gl-svg-textlayout-wayland-x11.tar.gz -> skia-binaries-0.62.0.tar.gz
	"
	inherit git-r3
	EGIT_REPO_URI="https://github.com/neovide/neovide"
else
	SRC_URI="
		https://codeload.github.com/neovide/neovide/tar.gz/refs/tags/${PV} -> ${P}.tar.gz
		https://github.com/rust-skia/skia-binaries/releases/download/0.62.0/skia-binaries-8cf4841aefdb295709e9-x86_64-unknown-linux-gnu-egl-gl-svg-textlayout-wayland-x11.tar.gz -> skia-binaries-0.62.0.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="
	Apache-1.0 Apache-2.0 BSD Boost-1.0 CC0-1.0 ISC LGPL-3 MIT MPL-2.0
	OFL-1.1 SSLeay Unicode-DFS-2016
"
SLOT="0"
IUSE="lunarvim test wayland +X"

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
}

src_configure() {
	cargo_src_configure
}

src_compile() {
	# The skia-bindings binary_cache feature requires us to point to the .tar.gz
	export SKIA_BINARIES_URL="file://${DISTDIR}/skia-binaries-0.62.0.tar.gz"

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
