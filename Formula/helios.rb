class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.2.0/helios-darwin-arm64"
      sha256 "42d2ef9a6abba35b9dceb5b21de254a0117e38b23aa29a6018b06c637f53ecb2"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.2.0/helios-darwin-amd64"
      sha256 "5bd675cffe44d1a59aa96a2ad3bc65704320d483255c9527c94f3b16815a9b69"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.2.0/helios-linux-arm64"
      sha256 "3fc8d93781325d2ca2b9ddf7d26345d1daa5799e5e042794acfdc1f7b847e22d"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.2.0/helios-linux-amd64"
      sha256 "b2d9c999b1fbce98dca6b3f95b8b23a9ac33123c72d5ef4b933f2142a5035c87"
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
