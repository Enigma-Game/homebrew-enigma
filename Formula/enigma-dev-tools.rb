class EnigmaDevTools < Formula
  desc "Developer tools for Enigma game project"
  homepage "https://www.nongnu.org/enigma/"
  license "GPL-2.0-or-later"
  head "https://github.com/Enigma-Game/Enigma.git", branch: "master"

  stable do
    url "https://github.com/Enigma-Game/Enigma/releases/download/1.30/Enigma-1.30-src.tar.gz"
    sha256 "ae64b91fbc2b10970071d0d78ed5b4ede9ee3868de2e6e9569546fc58437f8af"
    # the files are now installed by enigmabuilddmg instead of enigma
    patch :DATA
  end

  livecheck do
    url :stable
    regex(/v?(\d+(?:\.\d+)+)$/i)
  end

  bottle :unneeded

  depends_on "coreutils"
  depends_on "create-dmg"
  depends_on "dylibbundler"
  depends_on "enigma"
  depends_on "fileicon"
  depends_on "imagemagick"
  depends_on :macos
  depends_on "osxutils"

  def install
    bin.install "etc/enigmabuilddmg"
    mkdir_p prefix/"etc"
    (prefix/"etc").install "etc/Info.plist"
    (prefix/"etc").install "etc/enigma.icns"
    (prefix/"etc").install "etc/menu_bg.jpg"
  end

  test do
    assert_equal "#!/bin/bash", shell_output("head -1 #{bin}/enigmabuilddmg").chomp
  end
end

__END__
diff --git a/etc/enigmabuilddmg b/etc/enigmabuilddmg
index 6457444..3198193 100755
--- a/etc/enigmabuilddmg
+++ b/etc/enigmabuilddmg
@@ -25,7 +25,7 @@ done
 DEST=/tmp/Enigma_temp_dist_build
 DMG_FILE_NAME="Enigma.dmg"
 ENIGMA_APP_DIR=`brew --prefix enigma`
-ENIGMABUILDDMG_DIR="$ENIGMA_APP_DIR/etc"
+ENIGMABUILDDMG_DIR="$(dirname $(dirname $(realpath ${BASH_SOURCE[0]})))/etc"
 ENIGMA_APP_PATH="$DEST/Enigma/Enigma.app"
 #BACKGROUND_IMAGE="$ENIGMA_APP_PATH/Contents/Resources/doc/images/menu_bg.jpg"
 BACKGROUND_IMAGE="$ENIGMABUILDDMG_DIR/menu_bg.jpg"
