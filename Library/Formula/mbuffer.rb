require 'formula'

class Mbuffer < Formula
  url 'http://www.maier-komor.de/software/mbuffer/mbuffer-20110724.tgz'
  version '20110724'
  homepage 'http://www.maier-komor.de/mbuffer.html'
  md5 'fc183b787f33011b42c9814029c69054'

  def install
    # possible options are
    # --enable-debug --enable-networking --disable-multivolume
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--enable-networking",
                          "--disable-multivolume"

    system "make"
    system "make install"
  end
end
