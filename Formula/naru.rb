class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.0.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.0.0/naru-darwin-arm64"
      sha256 "019b936f7716b63e6385faff2fc867fd31c13cd288ee0e2f241d80985f8b618e"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.0.0/naru-darwin-amd64"
      sha256 "3bc1a3b8c3b8bdd9cf1eea67a3af6c9edf237dfca316d0060f5523e50a2cb911"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.0.0/naru-linux-arm64"
      sha256 "baf9f248607378c423d7183cbc35844cea7d2b54ab8357b7f39caaf35c3411a4"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.0.0/naru-linux-amd64"
      sha256 "f8533a184002c9b4e79a828b11942451b7c9b92c497c3579137ca2884b44541e"
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
