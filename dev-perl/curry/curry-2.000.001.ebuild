# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=MSTROUT
DIST_VERSION=2.000001
inherit perl-module

DESCRIPTION="Create automatic curried method call closures for any class or object"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=" "

BDEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Harness
	)
"
