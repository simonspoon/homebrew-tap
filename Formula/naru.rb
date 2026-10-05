class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.3.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.3.0/naru-darwin-arm64"
      sha256 "49d25237d3c77d130cc85598ea13e437778c9f4428e907f4c07aeee0df0856ae"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.3.0/naru-darwin-amd64"
      sha256 "c8c9164bfb1aa217b7a2b1b98329f84873191215f5ef812cc6eb638aed738e2e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.3.0/naru-linux-arm64"
      sha256 "5a3f08b7f16733c18f1f11a52ba8f515911d84ee41b832c7b85c618933b57e33"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.3.0/naru-linux-amd64"
      sha256 "c46223f836f5de55c891d96071ab4ff795ab851e51151a24744cb733abd2c7ee"
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
