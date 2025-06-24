# Copyright Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=RKITOVER
DIST_VERSION=0.05
inherit perl-module

DESCRIPTION="Detect if English number is ordinal or cardinal"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/Lingua-EN-FindNumber-1.32
	virtual/perl-Exporter
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
