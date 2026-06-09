class Nyx < Formula
  desc "Index and search Claude Code conversation history"
  homepage "https://github.com/simonspoon/nyx"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.1/nyx-darwin-arm64"
      sha256 "401c2fb577a3365e4aadbdde1f760a0c16762e21b0fb7b2e45a1a16ae6b339c2"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.1/nyx-darwin-amd64"
      sha256 "8f76955c07c2cf50493c633b9986f4eebabdfc75f5f7c58a56956a3cdf2af000"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.1/nyx-linux-arm64"
      sha256 "95544934b1e64d601253e328d5e6cace62a46e85efdd05644001bad1529cf3e7"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.1/nyx-linux-amd64"
      sha256 "cb8dddba37687e4fa33fd4180d7f296d98e7e618ac6d61b44c3016624917430b"
    end
  end

  def install
    binary = Dir["nyx-*"].first || "nyx"
    bin.install binary => "nyx"
  end

  test do
    assert_match "nyx", shell_output("#{bin}/nyx --help")
  end
end
