# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ab_glyph@0.2.26
	ab_glyph_rasterizer@0.1.8
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.18
	android-activity@0.5.2
	android-properties@0.2.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.14
	anstyle-parse@0.2.4
	anstyle-query@1.0.3
	anstyle-wincon@3.0.3
	anstyle@1.0.7
	anyhow@1.0.86
	approx@0.5.1
	arrayref@0.3.7
	arrayvec@0.7.4
	as-raw-xcb-connection@1.0.1
	async-trait@0.1.80
	atomic-waker@1.1.2
	autocfg@1.3.0
	backtrace@0.3.71
	bindgen@0.69.4
	bitflags@1.3.2
	bitflags@2.5.0
	block-sys@0.2.1
	block2@0.3.0
	block@0.1.6
	bumpalo@3.16.0
	bytemuck@1.16.0
	bytemuck_derive@1.6.1
	byteorder@1.5.0
	bytes@0.4.12
	bytes@1.6.0
	calloop-wayland-source@0.2.0
	calloop@0.12.4
	cc@1.0.98
	cesu8@1.1.0
	cexpr@0.6.0
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	cgl@0.3.2
	chrono@0.4.38
	clang-sys@1.7.0
	clap@4.5.4
	clap_builder@4.5.2
	clap_derive@4.5.4
	clap_lex@0.7.0
	clipboard-win@3.1.1
	colorchoice@1.0.1
	combine@4.6.7
	concurrent-queue@2.5.0
	convert_case@0.6.0
	copypasta@0.10.1
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	core-graphics-types@0.1.3
	core-graphics@0.23.2
	crc32fast@1.4.2
	crossbeam-channel@0.5.13
	crossbeam-utils@0.8.20
	csscolorparser@0.6.2
	cursor-icon@1.1.0
	deranged@0.3.11
	derive-new@0.6.0
	dirs-sys@0.4.1
	dirs@5.0.1
	dispatch@0.2.0
	dlib@0.5.2
	downcast-rs@1.2.1
	either@1.12.0
	equivalent@1.0.1
	errno@0.3.9
	euclid@0.22.10
	fdeflate@0.3.4
	file-id@0.2.1
	filetime@0.2.23
	flate2@1.0.30
	flexi_logger@0.28.0
	font-types@0.5.3
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	foreign-types@0.5.0
	fsevent-sys@4.1.0
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	futures@0.1.31
	futures@0.3.30
	gethostname@0.4.3
	getrandom@0.1.16
	getrandom@0.2.15
	gimli@0.28.1
	gl@0.14.0
	gl_generator@0.14.0
	glob@0.3.1
	glutin-winit@0.4.2
	glutin@0.31.3
	glutin_egl_sys@0.6.0
	glutin_glx_sys@0.5.0
	glutin_wgl_sys@0.5.0
	hashbrown@0.14.5
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	home@0.5.9
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	icrate@0.0.4
	image@0.25.1
	indexmap@2.2.6
	indoc@2.0.5
	inotify-sys@0.1.5
	inotify@0.9.6
	iovec@0.1.4
	is_terminal_polyfill@1.70.0
	itertools@0.12.1
	itoa@1.0.11
	jni-sys@0.3.0
	jni@0.21.1
	jobserver@0.1.31
	js-sys@0.3.69
	khronos_api@3.1.0
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lazy-bytes-cast@5.0.1
	lazy_static@1.4.0
	lazycell@1.3.0
	libc@0.2.155
	libloading@0.8.3
	libredox@0.0.2
	libredox@0.1.3
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.21
	lru@0.12.3
	malloc_buf@0.0.6
	memchr@2.7.2
	memmap2@0.9.4
	minimal-lexical@0.2.1
	miniz_oxide@0.7.3
	mio@0.8.11
	ndk-context@0.1.1
	ndk-sys@0.5.0+25.2.9519653
	ndk@0.8.0
	nom@7.1.3
	notify-debouncer-full@0.3.1
	notify@6.1.1
	num-bigint@0.4.5
	num-complex@0.4.6
	num-conv@0.1.0
	num-integer@0.1.46
	num-iter@0.1.45
	num-rational@0.4.2
	num-traits@0.2.19
	num@0.4.3
	num_cpus@1.16.0
	num_enum@0.7.2
	num_enum_derive@0.7.2
	nvim-rs@0.7.0
	objc-foundation@0.1.1
	objc-sys@0.3.5
	objc2-encode@3.0.0
	objc2@0.4.1
	objc@0.2.7
	objc_id@0.1.1
	object@0.32.2
	once_cell@1.19.0
	option-ext@0.2.0
	orbclient@0.3.47
	owned_ttf_parser@0.21.0
	parity-tokio-ipc@0.9.0
	parking_lot@0.12.2
	parking_lot_core@0.9.10
	paste@1.0.15
	percent-encoding@2.3.1
	phf@0.11.2
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.11.2
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	pkg-config@0.3.30
	png@0.17.13
	polling@3.7.0
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	prettyplease@0.2.20
	proc-macro-crate@3.1.0
	proc-macro2@1.0.83
	quick-xml@0.31.0
	quote@1.0.36
	rand@0.7.3
	rand@0.8.5
	rand_chacha@0.2.2
	rand_chacha@0.3.1
	rand_core@0.5.1
	rand_core@0.6.4
	rand_hc@0.2.0
	raw-window-handle@0.5.2
	raw-window-handle@0.6.2
	read-fonts@0.19.1
	redox_syscall@0.3.5
	redox_syscall@0.4.1
	redox_syscall@0.5.1
	redox_users@0.4.5
	regex-automata@0.4.6
	regex-syntax@0.8.3
	regex@1.10.4
	rmp@0.8.14
	rmpv@1.3.0
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustix@0.38.34
	rustversion@1.0.17
	ryu@1.0.18
	same-file@1.0.6
	scc@2.1.1
	scoped-env@2.1.0
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sctk-adwaita@0.8.1
	sdd@0.2.0
	serde@1.0.202
	serde_derive@1.0.202
	serde_json@1.0.117
	serde_spanned@0.6.6
	serial_test@3.1.1
	serial_test_derive@3.1.1
	shlex@1.3.0
	signal-hook-registry@1.4.2
	simd-adler32@0.3.7
	siphasher@0.3.11
	skia-bindings@0.73.0
	skia-safe@0.73.0
	slab@0.4.9
	smallvec@1.13.2
	smithay-client-toolkit@0.18.1
	smithay-clipboard@0.7.1
	smol_str@0.2.2
	socket2@0.5.7
	spin_sleep@1.2.0
	strict-num@0.1.1
	strsim@0.11.1
	strum@0.26.2
	strum_macros@0.26.2
	swash@0.1.16
	syn@1.0.109
	syn@2.0.66
	tar@0.4.40
	thiserror-impl@1.0.61
	thiserror@1.0.61
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tiny-skia-path@0.11.4
	tiny-skia@0.11.4
	tokio-io@0.1.13
	tokio-macros@2.2.0
	tokio-util@0.7.11
	tokio@1.37.0
	toml@0.5.11
	toml@0.8.13
	toml_datetime@0.6.6
	toml_edit@0.21.1
	toml_edit@0.22.13
	tracing-core@0.1.32
	tracing@0.1.40
	tracy-client-sys@0.22.2
	ttf-parser@0.21.1
	typed-path@0.7.1
	unicode-ident@1.0.12
	unicode-segmentation@1.11.0
	utf8parse@0.2.1
	version_check@0.9.4
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.9.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-futures@0.4.42
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	wayland-backend@0.3.3
	wayland-client@0.31.2
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.1
	wayland-protocols-plasma@0.2.0
	wayland-protocols-wlr@0.2.0
	wayland-protocols@0.31.2
	wayland-scanner@0.31.1
	wayland-sys@0.31.1
	web-sys@0.3.69
	web-time@0.2.4
	which@4.4.2
	which@6.0.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-core@0.56.0
	windows-implement@0.56.0
	windows-interface@0.56.0
	windows-registry@0.1.1
	windows-result@0.1.1
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows@0.56.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winit@0.29.15
	winnow@0.5.40
	winnow@0.6.8
	winres@0.1.12
	winsafe@0.0.19
	wslpath-rs@0.1.0
	x11-clipboard@0.9.2
	x11-dl@2.21.0
	x11rb-protocol@0.13.1
	x11rb@0.13.1
	xattr@1.3.1
	xcursor@0.3.5
	xdg@2.5.2
	xkbcommon-dl@0.4.2
	xkeysym@0.2.0
	xml-rs@0.8.20
	zerocopy-derive@0.7.34
	zerocopy@0.7.34
"

PYTHON_COMPAT=( python3_{10..13} )

inherit cargo desktop python-any-r1 xdg-utils

DESCRIPTION="Neovide: A No Nonsense Neovim Gui"
HOMEPAGE="https://neovide.dev"
SKIA_VERSION="0.73.0"

SRC_URI="
	https://codeload.github.com/neovide/neovide/tar.gz/refs/tags/${PV} -> ${P}.tar.gz
	https://github.com/rust-skia/skia-binaries/releases/download/${SKIA_VERSION}/skia-binaries-532a0a24135b37b65b91-x86_64-unknown-linux-gnu-egl-gl-svg-textlayout-wayland-x11.tar.gz -> skia-binaries-${SKIA_VERSION}.tar.gz
	${CARGO_CRATE_URIS}
"
LICENSE="
	Apache-1.0 Apache-2.0 BSD Boost-1.0 CC0-1.0 ISC LGPL-3 MIT MPL-2.0
	OFL-1.1 SSLeay Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"

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
	>=app-editors/neovim-0.10.0
"

BDEPEND="
	${COMMON_DEPEND}
	dev-build/cmake
	virtual/rust
"

# Cargo strips the final neovide binary (default functionality of a --release build).
QA_PRESTRIPPED="usr/bin/neovide"

src_unpack() {
	cargo_src_unpack

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
	export SKIA_BINARIES_URL="file://${DISTDIR}/skia-binaries-${SKIA_VERSION}.tar.gz"

	cargo_src_compile --features embed-fonts
}

src_install() {
	cargo_src_install

	domenu assets/neovide.desktop

	local i
	for i in 16x16 32x32 48x48 256x256; do
		newicon -s "${i}" assets/"${PN}"-"${i}".png "${PN}".png
	done
	doicon assets/"${PN}".svg
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
