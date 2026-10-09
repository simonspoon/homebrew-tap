class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.7.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.7.0/naru-darwin-arm64"
      sha256 "9cbff3cff8ecc56f06ad3531a3f0a722d9519397fef207ecadc2bc93af890631"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.7.0/naru-darwin-amd64"
      sha256 "fa8f98cdbad2726938247f0d3f3461cc9ae05a1a0c8068136f5052ac2f1a7456"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.7.0/naru-linux-arm64"
      sha256 "7d5b1b78a1fb0504ebd031b68e725c537c226a5cb7bae91e66c7ce1aafe49625"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.7.0/naru-linux-amd64"
      sha256 "cec322ca62141a990fdc5965e25b728b46e21b4c884b9ef66a2536cfe162af8c"
    end
  end

  def install
    binary = Dir["naru-*"].first || "naru"
    bin.install binary => "naru"
  end

  test do
    assert_match "naru", shell_output("#{bin}/naru --help")
  end
end
