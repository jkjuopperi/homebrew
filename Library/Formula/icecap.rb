require 'formula'

class Icecap < Formula
  head 'hg://http://hg.dovecot.org/icecap/'
  homepage 'http://icecap.irssi2.org/'

  def install
    system "./autogen.sh ; ./autogen.sh" if ARGV.build_head?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix} --without-ssl"
    system "make"
    system "make install"
  end
end
