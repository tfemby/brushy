# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=VEESH
DIST_VERSION=0.07053
inherit perl-module

DESCRIPTION="Create a DBIx schema based on a database"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/Carp-Clan-6.80.0
	>=dev-perl/Class-Accessor-Grouped-0.100.140
	>=dev-perl/Class-C3-Componentised-1.1.2
	>=dev-perl/Class-Inspector-1.360.0
	>=dev-perl/curry-2.000.001
	>=dev-perl/DBIx-Class-0.82.844-r1
	>=dev-perl/Class-Unload-0.110.0-r1
	>=dev-perl/Data-Dump-1.250.0
	>=dev-perl/Hash-Merge-0.302.0-r1
	>=dev-perl/Lingua-EN-Inflect-Number-1.12
	>=dev-perl/Lingua-EN-Inflect-Phrase-0.20
	>=dev-perl/Lingua-EN-Tagger-0.31
	>=dev-perl/MRO-Compat-0.150.0
	>=dev-perl/namespace-clean-0.270.0-r1
	>=dev-perl/Scope-Guard-0.210.0-r1
	>=dev-perl/String-CamelCase-0.04
	>=dev-perl/String-ToIdentifier-EN-0.12
	>=dev-perl/Try-Tiny-0.320.0
	>=dev-perl/Class-Unload-0.110.0-r1
	virtual/perl-Digest-MD5
	virtual/perl-Exporter
	virtual/perl-Scalar-List-Utils
"

# dev-perl/String-Toldentifier-EN

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		>=dev-perl/DBD-SQLite-1.760.0
		>=dev-perl/Test-Exception-0.430.0-r1
		>=dev-perl/Test-Warn-0.370.0
		>=dev-perl/Test-Deep-1.205.0
		>=dev-perl/Test-Differences-0.710.0
		virtual/perl-File-Temp
		virtual/perl-File-Path
	)
"
