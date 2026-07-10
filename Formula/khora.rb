class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.11/khora-darwin-arm64"
      sha256 "467aeb6eaa5fb39a33cbc65484351f98bd785309586b7f6f26a2d6d10ed28a99"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.11/khora-darwin-amd64"
      sha256 "e968701a02f638bd12680ff33638a855d5c7d43cff0d1ecb107f2abe0b9a9b40"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.11/khora-linux-arm64"
      sha256 "cd62a5ee8988239399fdedc8ab0022165a2f56a7d363cf5ba1ffe8ec7bdf4cf2"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.11/khora-linux-amd64"
      sha256 "261ba4df441e3ce196bff955dd8a93e3de417a39c3688e8d9479a700606f745b"
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
