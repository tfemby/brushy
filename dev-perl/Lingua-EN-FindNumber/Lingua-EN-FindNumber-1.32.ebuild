# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=NEILB
DIST_VERSION=1.32
inherit perl-module

DESCRIPTION="Locate (written) numbers in English text"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/Lingua-EN-Words2Nums-0.18
	virtual/perl-Exporter
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
