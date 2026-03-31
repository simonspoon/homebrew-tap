class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.7.0/helios-darwin-arm64"
      sha256 "93e9768c5784288d41f997910bbf0a3430f111e585e0e3751704c070f7fb8190"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.7.0/helios-darwin-amd64"
      sha256 "b42b4d0606f2533657fe323db7791b4cf717f56692e58538afde3686eb0cad92"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.7.0/helios-linux-arm64"
      sha256 "0859ce12a7d9f4566f8992bdd934830d209110a7db9d5512beb8d089e5bab6d1"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.7.0/helios-linux-amd64"
      sha256 "a1b05ed9d448bedc0b518d3469b3288792291c9d962a803fc74be5e3f5457201"
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
