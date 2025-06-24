# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=JOEY
DIST_VERSION=0.18
inherit perl-module

DESCRIPTION="Convert English text to numbers"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=" "

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
