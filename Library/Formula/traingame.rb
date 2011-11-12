require 'formula'

class Traingame < Formula
  url 'http://www.nickg.me.uk/files/TrainGame-0.2.1.tar.gz'
  homepage 'http://www.doof.me.uk/train-game/'
  md5 '220af936e0d39a6db47f3fc6c5659b77'

  depends_on 'cmake' => :build
  depends_on 'boost'
  depends_on 'xerces-c'
  depends_on 'glew'
  depends_on 'sdl'
  depends_on 'sdl_image'

  def install
    system "cmake . #{std_cmake_parameters} -DCMAKE_SYSTEM_PREFIX_PATH=/opt/brew:/usr"
    system "make install"
  end
end
