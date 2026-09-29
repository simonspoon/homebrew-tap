class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "1.13.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.13.0/naru-darwin-arm64"
      sha256 "a0798057fb059c36757b510641a009b0bdad000ad0524369dcd894c6f2398764"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.13.0/naru-darwin-amd64"
      sha256 "68d502e225d6faf388742506cee2635e130c4874d3e35dda7212d74bf438210d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.13.0/naru-linux-arm64"
      sha256 "444a1fb8953f6519a8de90d9cf959c1025bb0b1e3403c9781f19c01137378d05"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.13.0/naru-linux-amd64"
      sha256 "02647399469295cec4b95c6af3e398bf8b86daf592ccc750da6edd5f148056d2"
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
