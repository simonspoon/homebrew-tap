class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "1.11.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.11.0/naru-darwin-arm64"
      sha256 "2e03385a7d07928fb4a5400d3e3400c3eb353f1fa6ca4b8c0fb559cd78b774a4"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.11.0/naru-darwin-amd64"
      sha256 "29e8633ffdddf1b9c6e7ca76917436ced2b3a615e0362e890a902c4279fca917"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.11.0/naru-linux-arm64"
      sha256 "70619e9035c5cbea3df7ad776bb3026338a21c7c5d2ea6486be78fc3ac02bf35"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.11.0/naru-linux-amd64"
      sha256 "84c2b1108e5fa6a21e6502cdc56c2fc3c4aa2c5680dbdd14a6faefdba97b06d6"
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
