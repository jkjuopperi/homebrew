require 'formula'

class Mksh < Formula
  url 'https://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R40b.cpio.gz'
  url 'http://pub.allbsd.org/MirOS/dist/mir/mksh/mksh-R40b.cpio.gz'
  version 'R40b'
  homepage 'https://www.mirbsd.org/mksh.htm'
  head 'cvs://_anoncvs@anoncvs.mirbsd.org:/cvs:mksh'
  md5 'afb08b65272ace550ec59b26a876a7de'

  def install
    system "sh Build.sh -r"
    system "install -d #{prefix}/bin"
    system "install -s -m 555 mksh #{prefix}/bin/mksh"
    system "install -d #{prefix}/share/doc/mksh/examples"
    system "install -m 444 dot.mkshrc #{prefix}/share/doc/mksh/examples/"
    system "install -d #{prefix}/share/man/man1"
    system "install -m 444 mksh.1 #{prefix}/share/man/man1/mksh.1"
  end
end
