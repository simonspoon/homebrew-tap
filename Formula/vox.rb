class Vox < Formula
  desc "Telegram async messaging CLI for Claude Code agents"
  homepage "https://github.com/simonspoon/vox"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/vox/releases/download/v0.1.0/vox-darwin-arm64"
      sha256 "2eeaf8a0f5ea75c3760284d67271ce0a2ae4dd685ba13e1d687d0ed41c29ba86"
    else
      url "https://github.com/simonspoon/vox/releases/download/v0.1.0/vox-darwin-amd64"
      sha256 "eb517cb7a2f99e136ef6752129e9e1e1d36b878076afa48fd2627aed9ee5d045"
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
