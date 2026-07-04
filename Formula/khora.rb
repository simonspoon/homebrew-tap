class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.7/khora-darwin-arm64"
      sha256 "c9a1a2f3732150f2086dee0d76e1e9d2bc86a11586c9144726e2cf86c7d2b9fe"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.7/khora-darwin-amd64"
      sha256 "7515315ef2012e43dc578ff9d2328b2c4f76d5b8d98bbd02b75e15659213f804"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.7/khora-linux-arm64"
      sha256 "33169cbaac8dd21571b733fa9392e72739db1d9bbcdda1a9c4738ec15ca6c208"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.7/khora-linux-amd64"
      sha256 "676561874748301572de9304c2bda7ce0952ba9ed47affbf5935c92bb06bd3b8"
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
