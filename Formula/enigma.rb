class Enigma < Formula
  desc "Puzzle game inspired by Oxyd and Rock'n'Roll"
  homepage "https://www.nongnu.org/enigma/"
  url "https://github.com/Enigma-Game/Enigma/releases/download/1.30-beta/Enigma-1.30-beta-macbuild-src.tar.gz"
  version "1.30"
  sha256 "fe0a8436b862159fbd7d17bad1684f8f1df33bdff1b801bb3f904f3dbaab509e"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    # This uses the git tag to get version numbers.
    # Stable releases should be tagged like 1.21.1 or 1.30
    # For now let it match on 1.30-beta so we can test with it
    # and remove the (?:\D.*)? at the end when 1.30 is released
    regex(/v?(\d+(?:\.\d+)+)(?:\D.*)?$/i)
  end

  bottle do
    root_url "https://github.com/Enigma-Game/homebrew-enigma/releases/download/enigma-1.30"
    sha256 mojave:       "7f7b01aadc387f457d205765dce3f3053a5f44452c8fe20b575d522aece01a39"
    sha256 catalina:     "aa9960a29a15c00bb81a8be1c77071252a2b62f565e2ecae711ace963d20234e"
    sha256 big_sur:      "a6a021df393980f860b60a49132e6fb598ff11f33cf515ac2dbc06be80b86dcc"
    sha256 x86_64_linux: "0b31cf13483d83f3e330d525b4e28c8daf81ee638739a4241daef3cf644e92b8"
  end

  head do
    url "https://github.com/Enigma-Game/Enigma.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "texi2html" => :build
  end

  depends_on "imagemagick" => :build
  depends_on "pkg-config" => :build
  depends_on "enet"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "libpng"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer"
  depends_on "sdl2_ttf"
  depends_on "xerces-c"

  on_linux do
    depends_on "gcc"
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--with-system-enet",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    system "strip", bin/"enigma"
    if build.head?
      system "make", "dist"
      mkdir_p prefix/"dist" if build.head?
      dist_tar = Dir["enigma-*.tar.gz"]
      odie "Unexpected number of artifacts!" if dist_tar.length != 1
      (prefix/"dist").install dist_tar
    end
    mkdir_p prefix/"etc"
    (prefix/"etc").install "etc/enigmabuilddmg"
    (prefix/"etc").install "etc/Info.plist"
    (prefix/"etc").install "etc/enigma.icns"
    (prefix/"etc").install "etc/menu_bg.jpg"
  end

  test do
    assert_equal "Enigma v#{version}", shell_output("#{bin}/enigma --version").chomp
  end
end
