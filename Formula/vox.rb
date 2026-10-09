class Vox < Formula
  desc "Telegram async messaging CLI for Claude Code agents"
  homepage "https://github.com/simonspoon/vox"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/vox/releases/download/v0.3.0/vox-darwin-arm64"
      sha256 "1f275b18dc340acabc4873e129aba76b7bd8e1e5856ffc023d2a1bd590c95608"
    else
      url "https://github.com/simonspoon/vox/releases/download/v0.3.0/vox-darwin-amd64"
      sha256 "fca0ba234230102b23c32fb78bfd2a9fed73e82cec8a75e2132bc16515df2cdf"
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
