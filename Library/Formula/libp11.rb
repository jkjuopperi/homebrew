require 'formula'

class Libp11 < Formula
  url 'http://www.opensc-project.org/files/libp11/libp11-0.2.8.tar.gz'
  homepage 'http://www.opensc-project.org/libp11'
  md5 'f46dcbbea13a0732ab095d36283d5060'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
