# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=NEILB
DIST_VERSION=1.12
inherit perl-module

DESCRIPTION="Force number of words to singular or plural"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/Lingua-EN-Inflect-1.905.0
	virtual/perl-Exporter
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
