require 'formula'

class EnginePkcs11 < Formula
  url 'http://www.opensc-project.org/files/engine_pkcs11/engine_pkcs11-0.1.8.tar.gz'
  homepage 'http://www.opensc-project.org/engine_pkcs11'
  md5 '693b402eafba152666e66431ed4c1b9e'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
