require 'formula'

class Uci < Formula
  homepage 'http://wiki.openwrt.org/doc/techref/uci'
  head 'git://github.com/jkjuopperi/uci.git'

  depends_on 'cmake' => :build

  def options
    [["--uci-debug", "Enable debugging"]]
  end

  def install
    args = ["."] + std_cmake_parameters.split + ["-DBUILD_LUA=OFF"]
    args << "-DUCI_DEBUG=ON" if ARGV.include? "--uci-debug"
    args << "-DDEBUG=1" if ARGV.include? "--uci-debug"
    system "cmake", *args
    system "make install"
  end
end
