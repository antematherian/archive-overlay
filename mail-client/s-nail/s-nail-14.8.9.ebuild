# Copyright 1999-2017 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="Actively maintained fork of heirloom-mailx, a CLI email client"
HOMEPAGE="https://www.sdaoden.eu/code.html"
SRC_URI="https://www.sdaoden.eu/downloads/${P}.tar.xz"

LICENSE="MIT BSD BSD-2 BSD-4 RSA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl
		virtual/krb5
		net-dns/libidn
		!mail-client/mailx
		!net-mail/mailutils"
RDEPEND="${DEPEND}"
PATCHES=""

src_configure() {
	tc-export CC

	emake \
		PREFIX="${EPREFIX}"/usr \
		SYSCONFDIR="${EPREFIX}"/etc \
		LIBEXECDIR="${EPREFIX}"/usr/lib \
		MAILSPOOL="${EPREFIX}"/var/spool/mail \
		SID= NAIL="mail" \
		WANT_AUTOCC=0 \
		config || die "emake failed"
}

src_compile() {
	emake build || die "emake failed"
	emake test || die "emake failed"
}

