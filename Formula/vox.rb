class Vox < Formula
  desc "Telegram async messaging CLI for Claude Code agents"
  homepage "https://github.com/simonspoon/vox"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/vox/releases/download/v0.1.0/vox-darwin-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/simonspoon/vox/releases/download/v0.1.0/vox-darwin-amd64"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    binary = Dir["vox-*"].first || "vox"
    bin.install binary => "vox"
  end

  test do
    assert_match "vox", shell_output("#{bin}/vox --help")
  end
end
