require 'formula'

class Luci < Formula
  url 'http://svn.luci.subsignal.org/luci/branches/luci-0.10',
    :using => SubversionDownloadStrategy
  head 'http://svn.luci.subsignal.org/luci/trunk',
    :using => SubversionDownloadStrategy
  homepage 'http://luci.subsignal.org/'

  depends_on 'lua'

  def install
    system "make"
  end
end
