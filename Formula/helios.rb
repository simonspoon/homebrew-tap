class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.9.0/helios-darwin-arm64"
      sha256 "ad4fa3ba94372f5f991052390c9f2c7f9fe0126fedcaa8ca1b6e2229cc076969"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.9.0/helios-darwin-amd64"
      sha256 "4d080a08abe7e371cb61665155279f8f61c1ba7adc7971d3889d3fe5447fce1f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.9.0/helios-linux-arm64"
      sha256 "2de93110a60d2a1a55e440873ea35e5e9b4f1898c02559467b6d9d9ca1771be6"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.9.0/helios-linux-amd64"
      sha256 "c68422069181f0a6fa045d81d655f14c01df6546417036f42c7e61aa3147632c"
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
