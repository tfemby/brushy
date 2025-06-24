# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=ARISTOTLE
DIST_VERSION=1.17
inherit perl-module

DESCRIPTION="Make functions faster by trading space for time"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	virtual/perl-Scalar-List-Utils
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
