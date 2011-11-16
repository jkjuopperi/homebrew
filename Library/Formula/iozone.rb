require 'formula'

class Iozone < Formula
  url 'http://www.iozone.org/src/current/iozone3_397.tar'
  homepage 'http://www.iozone.org/'
  md5 '276712db3ef2eb6896b0ca368d497d5d'

  def install
    Dir.chdir 'src/current' do

      system "chmod 0644 makefile"

      inreplace "makefile" do |s|
        s.remove_make_var! "CC"
        s.remove_make_var! "CFLAGS"
      end

      system "make macosx"

      bin.install ['iozone', 'fileop', 'pit_server']

      doc.install [
        'Generate_Graphs',
        'Gnuplot.txt',
        'client_list',
        'gengnuplot.sh',
        'gnu3d.dem',
        'gnuplot.dem',
        'gnuplotps.dem',
        'iozone_visualizer.pl',
        'read_telemetry',
        'report.pl',
        'write_telemetry'
      ]

    end

    Dir.chdir 'docs' do
      man1.install 'iozone.1'
      doc.install Dir['*']
    end

  end
end
