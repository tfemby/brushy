# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=HIO
DIST_VERSION=0.04
inherit perl-module

DESCRIPTION="Create a DBIx schema based on a database"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=" "

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
