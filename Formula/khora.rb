class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.15"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.15/khora-darwin-arm64"
      sha256 "578a5e368ce423f7a83e70c933760885e21c623d7d2b27b0657d06911567d37b"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.15/khora-darwin-amd64"
      sha256 "bd3aa689040412357b57f69f58880ec4de4f1915781afd7f35c0ab6a66bdd687"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.15/khora-linux-arm64"
      sha256 "0999b993caf4408485fdfb9a4f8021e84be4f42c6b4781206f8f558eb524a52d"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.15/khora-linux-amd64"
      sha256 "9299ff8dc9e4785a76b3031accf2ca0087e5b0f1ff6d3ba270e50da49fa8f476"
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
