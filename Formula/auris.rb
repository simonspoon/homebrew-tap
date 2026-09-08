class Auris < Formula
  desc "Command-line speech-to-text with Parakeet TDT 0.6B v2, transcribing audio from stdin"
  homepage "https://github.com/simonspoon/auris"
  version "0.1.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/auris/releases/download/v0.1.0/auris-darwin-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/simonspoon/auris/releases/download/v0.1.0/auris-darwin-amd64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/auris/releases/download/v0.1.0/auris-linux-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/simonspoon/auris/releases/download/v0.1.0/auris-linux-amd64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    binary = Dir["auris-*"].first || "auris"
    bin.install binary => "auris"
  end

  test do
    assert_match "Speech-to-text", shell_output("#{bin}/auris --help")
  end
end
