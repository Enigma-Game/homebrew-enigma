cask "enigma" do
  version "1.30-beta"
  sha256 "b99b128408d7a854c8e3e9ec8472b518c8941801484e078f54b81044f4798421"

  url "https://github.com/Enigma-Game/Enigma/releases/download/#{version}/Enigma-#{version}.dmg",
      verified: "github.com/Enigma-Game/"
  name "Enigma"
  desc "Puzzle game inspired by Oxyd and Rock'n'Roll"
  homepage "https://www.nongnu.org/enigma/"

  livecheck do
    url :url
    regex(/v?(\d+(?:\.\d+)+(?:\D.*)?)$/i)
  end

  suite "Enigma"

  zap trash: [
    "~/.enigmarc.xml",
    "~/Library/Application Support/Enigma",
  ]
end
