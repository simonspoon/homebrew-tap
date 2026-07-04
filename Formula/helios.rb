class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.21.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.21.0/helios-darwin-arm64"
      sha256 "55b313941641f69fa9808b8621120eb4595459ca5b2ddca6d704f43dd8028052"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.21.0/helios-darwin-amd64"
      sha256 "724dc9680bbf7f88f25759468fb4f07cf23fd8fc2203b1f96c142398c664c30e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.21.0/helios-linux-arm64"
      sha256 "11cece425ba6a503da05ee1cb1dba645d266dda23904fc06d7574191c5188500"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.21.0/helios-linux-amd64"
      sha256 "3d2fffcc876c295427740a896c49ca13eeb69640a5f2a56406c946df3781b8e6"
    end
  end

  def install
    binary = Dir["helios-*"].first || "helios"
    bin.install binary => "helios"
  end

  test do
    assert_match "helios", shell_output("#{bin}/helios --help")
  end
end
