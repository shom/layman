# Copyright 1999-2010 Tiziano M眉ller
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils

DESCRIPTION="A free console file manager."
HOMEPAGE="http://savannah.nongnu.org/projects/ranger"
SRC_URI="http://download.savannah.gnu.org/releases/ranger/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}" 

src_compile() {
	distutils_src_compile

	if use doc ; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc ; then
		dohtml doc/pydoc/*
	fi
}

src_test() {
	testing() {
		"$(PYTHON)" test/all_tests.py 1 || die "test failed for ABI ${PYTHON_ABI}"
	}
	python_execute_function testing
}

