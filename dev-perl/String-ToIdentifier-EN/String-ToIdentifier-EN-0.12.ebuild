# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=RKITOVER
DIST_VERSION=0.12
inherit perl-module

DESCRIPTION="Convert Strings to English Program Identifiers"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/Lingua-EN-Inflect-Phrase-0.20
	>=dev-perl/Text-Unidecode-0.270.0-r1
	virtual/perl-Exporter
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
