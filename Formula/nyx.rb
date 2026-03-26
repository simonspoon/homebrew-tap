class Nyx < Formula
  desc "Index and search Claude Code conversation history"
  homepage "https://github.com/simonspoon/nyx"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.0/nyx-darwin-arm64"
      sha256 "a4eb81c72a69c2d0ce727d1d8a6721036c5086e8a0bfe45a0d006d08c9e9df71"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.0/nyx-darwin-amd64"
      sha256 "59067317841febbe7ed2b2ef56ab7f6b85de2b9ccd5f30346ebb8050aabcc436"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.0/nyx-linux-arm64"
      sha256 "41e0288de5f98c739fe3db9f27cbf745c4c3a13b8b2be9776e33c586cfc77ae1"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.0/nyx-linux-amd64"
      sha256 "39c30aef2cd7e13969739a1450d59c23d8ae14c4fdfeef487bda860fd02941e9"
    end
  end

  def install
    binary = Dir["nyx-*"].first || "nyx"
    bin.install binary => "nyx"
  end

  test do
    assert_match "nyx", shell_output("#{bin}/nyx --help")
  end
end
