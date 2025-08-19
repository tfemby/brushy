# Copyright 2023-2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ab_glyph@0.2.31
	ab_glyph_rasterizer@0.1.9
	addr2line@0.24.2
	adler2@2.0.1
	ahash@0.8.12
	aho-corasick@1.1.3
	allocator-api2@0.2.21
	android-activity@0.6.0
	android-properties@0.2.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.19
	anstyle-parse@0.2.7
	anstyle-query@1.1.3
	anstyle-wincon@3.0.9
	anstyle@1.0.11
	anyhow@1.0.98
	approx@0.5.1
	arrayref@0.3.9
	arrayvec@0.7.6
	as-raw-xcb-connection@1.0.1
	async-trait@0.1.88
	atomic-waker@1.1.2
	autocfg@1.5.0
	backtrace@0.3.75
	bindgen@0.71.1
	bitflags@1.3.2
	bitflags@2.9.1
	block2@0.5.1
	bumpalo@3.19.0
	bytemuck@1.23.1
	bytemuck_derive@1.10.0
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@0.4.12
	bytes@1.10.1
	calloop-wayland-source@0.3.0
	calloop@0.13.0
	cc@1.2.30
	cesu8@1.1.0
	cexpr@0.6.0
	cfg-if@1.0.1
	cfg_aliases@0.2.1
	cgl@0.3.2
	chrono@0.4.41
	clang-sys@1.8.1
	clap@4.5.41
	clap_builder@4.5.41
	clap_derive@4.5.41
	clap_lex@0.7.5
	clipboard-win@5.4.1
	colorchoice@1.0.4
	combine@4.6.7
	concurrent-queue@2.5.0
	convert_case@0.7.1
	copypasta@0.10.2
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	core-graphics-types@0.1.3
	core-graphics@0.23.2
	crc32fast@1.5.0
	crossbeam-utils@0.8.21
	csscolorparser@0.7.2
	cursor-icon@1.2.0
	deranged@0.4.0
	derive-new@0.7.0
	dirs-sys@0.5.0
	dirs@6.0.0
	dispatch2@0.3.0
	dispatch@0.2.0
	dlib@0.5.2
	downcast-rs@1.2.1
	dpi@0.1.2
	either@1.15.0
	env_home@0.1.0
	equivalent@1.0.2
	errno@0.3.13
	error-code@3.3.2
	fdeflate@0.3.7
	file-id@0.2.2
	filetime@0.2.25
	flate2@1.1.2
	flexi_logger@0.30.2
	foldhash@0.1.5
	font-types@0.9.0
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	foreign-types@0.5.0
	fsevent-sys@4.1.0
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	futures@0.1.31
	futures@0.3.31
	gethostname@0.4.3
	getrandom@0.2.16
	getrandom@0.3.3
	gimli@0.31.1
	gl@0.14.0
	gl_generator@0.14.0
	glam@0.30.4
	glamour@0.16.0
	glob@0.3.2
	glutin-winit@0.5.0
	glutin@0.32.3
	glutin_egl_sys@0.7.1
	glutin_glx_sys@0.6.1
	glutin_wgl_sys@0.6.1
	hashbrown@0.15.4
	heck@0.5.0
	hermit-abi@0.5.2
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.63
	image@0.25.6
	indexmap@2.10.0
	indoc@2.0.6
	inotify-sys@0.1.5
	inotify@0.11.0
	io-uring@0.7.8
	iovec@0.1.4
	is_terminal_polyfill@1.70.1
	itertools@0.13.0
	itertools@0.14.0
	itoa@1.0.15
	jni-sys@0.3.0
	jni@0.21.1
	jobserver@0.1.33
	js-sys@0.3.77
	khronos_api@3.1.0
	kqueue-sys@1.0.4
	kqueue@1.1.1
	lazy_static@1.5.0
	libc@0.2.174
	libloading@0.8.8
	libredox@0.1.6
	linux-raw-sys@0.4.15
	linux-raw-sys@0.9.4
	lock_api@0.4.13
	log@0.4.27
	lru@0.13.0
	memchr@2.7.5
	memmap2@0.9.7
	minimal-lexical@0.2.1
	miniz_oxide@0.8.9
	mio@1.0.4
	ndk-context@0.1.1
	ndk-sys@0.6.0+11769913
	ndk@0.9.0
	nom@7.1.3
	notify-debouncer-full@0.5.0
	notify-types@2.0.0
	notify@8.1.0
	num-bigint@0.4.6
	num-complex@0.4.6
	num-conv@0.1.0
	num-integer@0.1.46
	num-iter@0.1.45
	num-rational@0.4.2
	num-traits@0.2.19
	num@0.4.3
	num_enum@0.7.4
	num_enum_derive@0.7.4
	nvim-rs@0.9.2
	objc-sys@0.3.5
	objc2-app-kit@0.2.2
	objc2-app-kit@0.3.1
	objc2-cloud-kit@0.2.2
	objc2-contacts@0.2.2
	objc2-core-data@0.2.2
	objc2-core-foundation@0.3.1
	objc2-core-image@0.2.2
	objc2-core-location@0.2.2
	objc2-encode@4.1.0
	objc2-foundation@0.2.2
	objc2-foundation@0.3.1
	objc2-link-presentation@0.2.2
	objc2-metal@0.2.2
	objc2-quartz-core@0.2.2
	objc2-symbols@0.2.2
	objc2-ui-kit@0.2.2
	objc2-uniform-type-identifiers@0.2.2
	objc2-user-notifications@0.2.2
	objc2@0.5.2
	objc2@0.6.1
	object@0.36.7
	once_cell@1.21.3
	once_cell_polyfill@1.70.1
	option-ext@0.2.0
	orbclient@0.3.48
	owned_ttf_parser@0.25.0
	parking_lot@0.12.4
	parking_lot_core@0.9.11
	paste@1.0.15
	percent-encoding@2.3.1
	phf@0.11.3
	phf_generator@0.11.3
	phf_macros@0.11.3
	phf_shared@0.11.3
	pin-project-internal@1.1.10
	pin-project-lite@0.2.16
	pin-project@1.1.10
	pin-utils@0.1.0
	pkg-config@0.3.32
	png@0.17.16
	polling@3.9.0
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	prettyplease@0.2.35
	proc-macro-crate@3.3.0
	proc-macro2@1.0.95
	quick-xml@0.37.5
	quote@1.0.40
	r-efi@5.3.0
	rand@0.8.5
	rand@0.9.1
	rand_chacha@0.9.0
	rand_core@0.6.4
	rand_core@0.9.3
	raw-window-handle@0.6.2
	read-fonts@0.29.3
	redox_syscall@0.4.1
	redox_syscall@0.5.14
	redox_users@0.5.0
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rmp@0.8.14
	rmpv@1.3.0
	rustc-demangle@0.1.25
	rustc-hash@2.1.1
	rustix@0.38.44
	rustix@1.0.8
	rustversion@1.0.21
	ryu@1.0.20
	same-file@1.0.6
	scc@2.3.4
	scoped-env@2.1.0
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sctk-adwaita@0.10.1
	sdd@3.0.10
	serde@1.0.219
	serde_derive@1.0.219
	serde_json@1.0.141
	serde_spanned@0.6.9
	serial_test@3.2.0
	serial_test_derive@3.2.0
	shlex@1.3.0
	signal-hook-registry@1.4.5
	simd-adler32@0.3.7
	siphasher@1.0.1
	skia-bindings@0.84.0
	skia-safe@0.84.0
	skrifa@0.31.3
	slab@0.4.10
	smallvec@1.15.1
	smithay-client-toolkit@0.19.2
	smithay-clipboard@0.7.2
	smol_str@0.2.2
	socket2@0.5.10
	spin_sleep@1.3.2
	strict-num@0.1.1
	strsim@0.11.1
	strum@0.26.3
	strum_macros@0.26.4
	swash@0.2.5
	syn@2.0.104
	tar@0.4.44
	thiserror-impl@1.0.69
	thiserror-impl@2.0.12
	thiserror@1.0.69
	thiserror@2.0.12
	time-core@0.1.4
	time-macros@0.2.22
	time@0.3.41
	tiny-skia-path@0.11.4
	tiny-skia@0.11.4
	tokio-io@0.1.13
	tokio-macros@2.5.0
	tokio-util@0.7.15
	tokio@1.46.1
	toml@0.5.11
	toml@0.8.23
	toml_datetime@0.6.11
	toml_edit@0.22.27
	toml_write@0.1.2
	tracing-core@0.1.34
	tracing@0.1.41
	tracy-client-sys@0.24.3
	ttf-parser@0.25.1
	typed-path@0.10.0
	unicode-ident@1.0.18
	unicode-segmentation@1.12.0
	utf8parse@0.2.2
	uzers@0.12.1
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-futures@0.4.50
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	wayland-backend@0.3.10
	wayland-client@0.31.10
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.10
	wayland-protocols-plasma@0.3.8
	wayland-protocols-wlr@0.3.8
	wayland-protocols@0.32.8
	wayland-scanner@0.31.6
	wayland-sys@0.31.6
	web-sys@0.3.77
	web-time@1.1.0
	which@7.0.3
	winapi-util@0.1.9
	windows-collections@0.2.0
	windows-core@0.61.2
	windows-future@0.2.1
	windows-implement@0.60.0
	windows-interface@0.59.1
	windows-link@0.1.3
	windows-numerics@0.2.0
	windows-registry@0.5.3
	windows-result@0.3.4
	windows-strings@0.4.2
	windows-sys@0.45.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows-targets@0.53.2
	windows-threading@0.1.0
	windows@0.61.3
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.0
	winit@0.30.9
	winnow@0.7.12
	winres@0.1.12
	winsafe@0.0.19
	wit-bindgen-rt@0.39.0
	wslpath-rs@0.2.0
	x11-clipboard@0.9.3
	x11-dl@2.21.0
	x11rb-protocol@0.13.1
	x11rb@0.13.1
	xattr@1.5.1
	xcursor@0.3.10
	xdg@2.5.2
	xkbcommon-dl@0.4.2
	xkeysym@0.2.1
	xml-rs@0.8.27
	yazi@0.2.1
	zeno@0.3.3
	zerocopy-derive@0.8.26
	zerocopy@0.8.26
"

PYTHON_COMPAT=( python3_{10..14} )

inherit cargo desktop python-any-r1 xdg-utils

DESCRIPTION="Neovide: A No Nonsense Neovim Gui"
HOMEPAGE="https://neovide.dev"
SKIA_VERSION="0.84.0"
SKIA_COMMIT="8df1749a67a2800c2904"

SRC_URI="
	https://codeload.github.com/neovide/neovide/tar.gz/refs/tags/${PV} -> ${P}.tar.gz
	amd64? ( https://github.com/rust-skia/skia-binaries/releases/download/${SKIA_VERSION}/skia-binaries-${SKIA_COMMIT}-x86_64-unknown-linux-gnu-egl-gl-svg-textlayout-wayland-x11.tar.gz -> skia-binaries-${SKIA_VERSION}-amd64.tar.gz )
	arm64? ( https://github.com/rust-skia/skia-binaries/releases/download/${SKIA_VERSION}/skia-binaries-${SKIA_COMMIT}-aarch64-unknown-linux-gnu-egl-gl-svg-textlayout-wayland-x11.tar.gz -> skia-binaries-${SKIA_VERSION}-arm64.tar.gz )
	${CARGO_CRATE_URIS}
"
LICENSE="
	Apache-1.0 Apache-2.0 BSD Boost-1.0 CC0-1.0 ISC LGPL-3 MIT MPL-2.0
	OFL-1.1 SSLeay Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

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
"

src_unpack() {
	cargo_src_unpack

	# Change builddir so our lib patch works.
	mv "${S}" "${WORKDIR}/${PN}"
	S="${WORKDIR}/${PN}"

	# GL and EGL don't seem to work using the export method. We're adding ld args in build.rs.
	eapply "${FILESDIR}/01_neovide-include-libs.patch"
}

src_prepare() {
	rust_pkg_setup
	cargo_update_crates
	eapply_user

	# Prevents rust from stripping the final binary - let portage do it
	sed -i "${S}/Cargo.toml" -e 's/strip = true/strip = false/'
}

src_configure() {
	# Revdeps need access to these libraries. This allows the build.rs not being responsible for linking them.
	# Not fully sure right now if I can do the same for gl and egl since we're using a binary for skia.
	export EXPAT_NO_VENDOR=1
	export ZLIB_NO_VENDOR=1
	export LIBPNG16_NO_VENDOR=1
	export LIBJPEG_NO_VENDOR=1
	export LIBWEBP_NO_VENDOR=1

	cargo_src_configure --frozen
}

src_compile() {
	# The skia-bindings binary_cache feature requires us to point to the .tar.gz
	use amd64 && export SKIA_BINARIES_URL="file://${DISTDIR}/skia-binaries-${SKIA_VERSION}-amd64.tar.gz"
	use arm64 && export SKIA_BINARIES_URL="file://${DISTDIR}/skia-binaries-${SKIA_VERSION}-arm64.tar.gz"

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
	einfo "If your device doesn't support opengl 3.3, try this workaround:"
	einfo "https://github.com/neovide/neovide/issues/2068#issuecomment-1754110369"
	einfo ""
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
