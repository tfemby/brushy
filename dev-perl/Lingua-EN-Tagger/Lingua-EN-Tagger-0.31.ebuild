# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=ACOBURN
DIST_VERSION=0.31
inherit perl-module

DESCRIPTION="Inflect short English Phrases"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/HTML-Parser-3.830.0
	>=dev-perl/HTML-Tagset-3.240.0
	>=dev-perl/Lingua-Stem-2.310.0
	>=dev-perl/Memoize-1.17
	>=dev-perl/Memoize-ExpireLRU-0.56
	virtual/perl-Storable
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-File-Spec
	test? (
		>=dev-perl/Test-NoWarnings-1.60.0
	)
"
