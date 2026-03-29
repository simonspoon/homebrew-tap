class Suda < Formula
  desc "Structured memory and knowledge management CLI for AI agent workflows"
  homepage "https://github.com/simonspoon/suda"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/suda/releases/download/v0.3.0/suda-darwin-arm64"
      sha256 "a9adec269891ed5bcb8ac46a42ec64908b4510095d4cee3bf36f192fa8ac0c84"
    else
      url "https://github.com/simonspoon/suda/releases/download/v0.3.0/suda-darwin-amd64"
      sha256 "b7d82a86b5aedb9537e4ccb225b68f86924901159760089554ecd8bb8e542ebf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/suda/releases/download/v0.3.0/suda-linux-arm64"
      sha256 "9781ca26d956056d1394ed4c3d578d36d3c8317f07505cab74cbcae85c214461"
    else
      url "https://github.com/simonspoon/suda/releases/download/v0.3.0/suda-linux-amd64"
      sha256 "b3dd178bdf0a97638239bb15c10e88bb9b3dfbc7a6353e25fb60545a69ddb85b"
    end
  end

  def install
    binary = Dir["suda-*"].first || "suda"
    bin.install binary => "suda"
  end

  test do
    assert_match "suda", shell_output("#{bin}/suda --help")
  end
end
