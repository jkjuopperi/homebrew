require 'formula'

class Lander < Formula
  url 'http://www.nickg.me.uk/files/lander-0.6.2.tar.gz'
  homepage 'http://www.doof.me.uk/lunar-lander/'
  md5 'd2735ecbfbd58f017ea2c8b8b9e29a19'

  depends_on 'boost'
  depends_on 'gettext'
  depends_on 'sdl'
  depends_on 'sdl_image'
  depends_on 'sdl_mixer'

  fails_with_llvm "Crashes with signal 11"

  def patches
    DATA
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "-with-boost=#{HOMEBREW_PREFIX}"
    system "make install"
  end
end
__END__
diff --git a/src/Main.cpp b/src/Main.cpp
index 1e5b257..7dc9913 100644
--- a/src/Main.cpp
+++ b/src/Main.cpp
@@ -238,14 +238,14 @@ string GetConfigDir()
    p /= "lander";
    create_directories(p);
 
-   return p.file_string() + "/";
+   return p.string() + "/";
 #else
 #ifdef WIN32
    path appdata(getenv("APPDATA"));
    appdata /= "doof.me.uk";
    appdata /= "Lander";
    create_directories(appdata);
-   return appdata.file_string() + "\\";
+   return appdata.string() + "\\";
 #else
 #error "Need to port GetConfigDir to this platform"
 #endif

