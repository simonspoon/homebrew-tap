class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.19"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.19/khora-darwin-arm64"
      sha256 "eaa62c9255d46d0063b1a439a90354595a46064a475fa93f428f82764961d7c5"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.19/khora-darwin-amd64"
      sha256 "46c7c0822fa36c76e1cb86927fa1e3b9af2e86e86c9bf09c84714e82f3d45a33"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.19/khora-linux-arm64"
      sha256 "d5ec8da7400f334820f1f2c4c4b79d315d1abda1e077dbd69a3b7aec846ab648"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.19/khora-linux-amd64"
      sha256 "7531a7d06bcf10e1f17da8f63d13295d8d7360c8e5d4b3da46140b550565acb6"
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
