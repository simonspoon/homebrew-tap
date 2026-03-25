class Xaku < Formula
  desc "Headless terminal multiplexer for agent automation"
  homepage "https://github.com/simonspoon/xaku"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/xaku/releases/download/v0.1.0/xaku-darwin-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/simonspoon/xaku/releases/download/v0.1.0/xaku-darwin-amd64"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/xaku/releases/download/v0.1.0/xaku-linux-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/simonspoon/xaku/releases/download/v0.1.0/xaku-linux-amd64"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    binary = Dir["xaku-*"].first || "xaku"
    bin.install binary => "xaku"
  end

  test do
    assert_match "xaku", shell_output("#{bin}/xaku --help")
  end
end
