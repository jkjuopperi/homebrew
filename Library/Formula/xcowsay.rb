require 'formula'

class Xcowsay < Formula
  url 'http://www.nickg.me.uk/files/xcowsay-1.3.tar.gz'
  head 'git://github.com/nickg/xcowsay.git'
  homepage 'http://www.doof.me.uk/xcowsay/'
  md5 'ffcad22a9002d2a5c37d9d302b9614d1'

  depends_on 'gtk+'
  depends_on 'gdk-pixbuf'

  def install
    system "autoreconf -f -i" unless File.exist? "configure"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
