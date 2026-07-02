class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.16.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.16.1/helios-darwin-arm64"
      sha256 "91b4722945f0465de90ce81a986427e0b66fad23f8b77078cb78aec265f6d53e"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.16.1/helios-darwin-amd64"
      sha256 "5adc5657da900d3cb343e15227a2d78e0e5fce389bfcada32b13ce23afbabf2d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.16.1/helios-linux-arm64"
      sha256 "ec202d460e5bc6f140235e6d011da05788b139ac2d3c52eae8a10f75b9193d17"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.16.1/helios-linux-amd64"
      sha256 "c7a14d05eecd656623f90932661a99dac533dbd0bc8e5889fa6fc89f6ff1c236"
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
