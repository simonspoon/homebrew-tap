class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.10/khora-darwin-arm64"
      sha256 "6c75c1765b6d27f06238b1061e59459e1c76a82b3ec2e78d56b700789494d682"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.10/khora-darwin-amd64"
      sha256 "7de6d85abd72e7a0ecc635306bd7a31f912319b4c34ea5fefe34a5d40f408907"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.10/khora-linux-arm64"
      sha256 "87dfd4b4e2b6f3a1b2d2830ec215db1538c61d8468e5c8f2e386512df5833f38"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.10/khora-linux-amd64"
      sha256 "996e3b9359b34b879bac997ca5ea15ed4954f39179f7dc17c5f115249c4ab91b"
    end
  end

  def install
    binary = Dir["khora-*"].first || "khora"
    bin.install binary => "khora"
  end

  test do
    assert_match "Web app QA automation", shell_output("#{bin}/khora --help")
  end
end
