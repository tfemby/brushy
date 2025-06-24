# Copyright Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=RKITOVER
DIST_VERSION=0.20
inherit perl-module

DESCRIPTION="Inflect short English Phrases"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/Lingua-EN-FindNumber-1.32
	>=dev-perl/Lingua-EN-Inflect-1.905.0
	>=dev-perl/Lingua-EN-Inflect-Number-1.12
	>=dev-perl/Lingua-EN-Number-IsOrdinal-0.05
	>=dev-perl/Lingua-EN-Tagger-0.31
	virtual/perl-Exporter
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		>=dev-perl/Test-NoWarnings-1.60.0
	)
"
