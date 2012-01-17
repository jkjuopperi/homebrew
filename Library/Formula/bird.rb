require 'formula'

class Bird < Formula
  url 'ftp://bird.network.cz/pub/bird/bird-1.3.5.tar.gz'
  #head 'git://git.nic.cz/bird.git'
  head 'git://github.com/jkjuopperi/bird.git'
  homepage 'http://bird.network.cz/'
  md5 '9efc2b1c05fa6298a8df60f5147ad5c1'

  depends_on 'readline'

  def install
    system "autoconf" unless File.exist? "configure"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--with-sysconfig=bsd"
    system "make install"

    # Write the launchd script
    (prefix + 'cz.network.bird.plist').write startup_plist
    (prefix + 'cz.network.bird.plist').chmod 0644
  end

  def caveats; <<-EOS
1) Create configuration file in #{etc}/bird.conf
2) Install launcd configuration:

   sudo cp -vf #{prefix}/cz.network.bird.plist /Library/LaunchDaemons/
   sudo chown -v root:wheel /Library/LaunchDaemons/cz.network.bird.plist

3) Start the daemon:

   sudo launchctl load -w /Library/LaunchDaemons/cz.network.bird.plist

EOS
  end

  def startup_plist
    return <<-EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd";>
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>cz.network.bird</string>
  <key>Program</key>
  <string>#{sbin}/bird</string>
  <key>KeepAlive</key>
  <dict>
    <key>NetworkState</key>
    <true/>
  </dict>
  <key>RunAtLoad</key>
  <true/>
  <key>WatchPaths</key>
  <array>
    <string>#{etc}/bird.conf</string>
  </array>
</dict>
</plist>
EOS
  end
end
