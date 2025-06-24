# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=NEILB
DIST_VERSION=0.56
inherit perl-module

DESCRIPTION="Expiry plug-in for Memoize that adds LRU cache expiration"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/Memoize-1.17
	virtual/perl-Carp
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
