require 'formula'

class YleDl < Formula
  url 'http://users.tkk.fi/~aajanki/rtmpdump-yle/rtmpdump-yle-1.4.5.tar.gz'
  homepage 'http://users.tkk.fi/~aajanki/rtmpdump-yle/'
  md5 'ce9e9e7500902214fcc9e392de72bbf0'

  depends_on 'json-c'

  def install
    ENV['XCFLAGS'] = "-I#{HOMEBREW_PREFIX}/include -I#{HOMEBREW_PREFIX}/include/json"
    ENV['XLDFLAGS'] = "-L#{HOMEBREW_PREFIX}/lib -liconv"
    inreplace 'Makefile', 'prefix=/usr/local', "prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
