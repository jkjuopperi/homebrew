require 'formula'

class Pkcs11Helper < Formula
  url 'http://www.opensc-project.org/files/pkcs11-helper/pkcs11-helper-1.09.tar.bz2'
  homepage 'http://www.opensc-project.org/opensc/wiki/pkcs11-helper'
  md5 '88ca59143f1b1d36283cab406f33a3fa'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
