require 'formula'

class StacklessPython < Formula
  url 'http://svn.python.org/projects/stackless/branches/release27-maint/'
  homepage ''
  md5 '437bbf43521aff110d6acc567df178d4'

  # depends_on 'cmake'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
