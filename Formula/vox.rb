class Vox < Formula
  desc "Telegram async messaging CLI for Claude Code agents"
  homepage "https://github.com/simonspoon/vox"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/vox/releases/download/v0.2.0/vox-darwin-arm64"
      sha256 "017abfd1645c915d0b53f622c1c378fe73a1abbb076612d16991947912c1fdbd"
    else
      url "https://github.com/simonspoon/vox/releases/download/v0.2.0/vox-darwin-amd64"
      sha256 "03e38ae0329472db747e2c9629c93837f42a2e1bf20ccc6f78c8f21ac6c0f11b"
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
