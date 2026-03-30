class Ivara < Formula
  desc "Claude Code session logging and analysis CLI"
  homepage "https://github.com/simonspoon/ivara"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/ivara/releases/download/v0.1.0/ivara-darwin-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/simonspoon/ivara/releases/download/v0.1.0/ivara-darwin-amd64"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/ivara/releases/download/v0.1.0/ivara-linux-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/simonspoon/ivara/releases/download/v0.1.0/ivara-linux-amd64"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    binary = Dir["ivara-*"].first || "ivara"
    bin.install binary => "ivara"
  end

  test do
    assert_match "ivara", shell_output("#{bin}/ivara --help")
  end
end
