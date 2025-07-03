# Copyright 2025 Daniella Kicsak
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=BRIANDFOY
DIST_VERSION=1.005
inherit perl-module

DESCRIPTION="Convert MultiMarkdown syntax to (X)HTML"

SLOT="0"
KEYWORDS="~amd64 ~x86"

# HTML::Entities provided by HTML::Parser
RDEPEND="
	>=dev-perl/HTML-Parser-3.830.0
	>=dev-perl/Text-Markdown-1.0.31-r2
	>=dev-perl/Text-Unidecode-1.300.0-r1
	virtual/perl-Digest-MD5
	virtual/perl-Encode
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		virtual/perl-File-Spec
	)
"
