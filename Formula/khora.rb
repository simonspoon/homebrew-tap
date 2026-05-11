class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.4/khora-darwin-arm64"
      sha256 "3b331fdfbff3fb3ab422ce8cbbc14cc030dc338f038f457e963bdedee4758c72"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.4/khora-darwin-amd64"
      sha256 "b61c85c892529c61aa46d961c40188c9288b08392f8fa6114ff124ccbc9e6f4a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.4/khora-linux-arm64"
      sha256 "e4c5b570c33077787b7ed3dc75b41d539a18c0fac017c994c347d853175e8fd8"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.4/khora-linux-amd64"
      sha256 "a66c970622cdc8bfd95384de986273e6a06e5d3c85d10ae7bc8c6e969c85f82e"
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
