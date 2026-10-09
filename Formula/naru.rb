class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.8.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.8.0/naru-darwin-arm64"
      sha256 "1650e78cf633c997b48eced7f36e64d81bd74adc5170c4aef0e6315717fe8e87"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.8.0/naru-darwin-amd64"
      sha256 "ca24080e967aaa524f2b5bea477d1c833bcd12f0e255c904cdcb98a3693ef010"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.8.0/naru-linux-arm64"
      sha256 "2ae2c120bc4a075cc7b758eb55fa19a07e83d5a5414f3af5f654eb87d49c79fa"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.8.0/naru-linux-amd64"
      sha256 "6276f8d0467ba29e0df320816f1edd75328c3d9ca50f7b46864bee7eba46e408"
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
