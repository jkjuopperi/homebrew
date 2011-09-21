require 'formula'

class PostgresqlAutodoc < Formula
  url 'http://www.rbt.ca/autodoc/binaries/postgresql_autodoc-1.40.tar.gz'
  homepage 'http://www.rbt.ca/autodoc/'
  md5 '68c91ec94051b45feb4ed801698c4149'
  head 'cvs://:pserver:anonymous@cvs.pgfoundry.org:/cvsroot/autodoc:autodoc'

  def install
    inreplace 'Makefile' do |s|
      s.remove_make_var! "PREFIX"
    end
    system "make", "install", "PREFIX=#{prefix}"
  end
end
