# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=PREACTION
DIST_VERSION=0.005
inherit perl-module

DESCRIPTION="Make functions faster by trading space for time"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/DBIx-Class-0.82.844
	>=dev-perl/Mojolicious-9.400.0
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
