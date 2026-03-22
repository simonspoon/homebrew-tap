class Loki < Formula
  desc "Desktop app automation CLI for macOS QA testing"
  homepage "https://github.com/simonspoon/loki"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/loki/releases/download/v0.1.0/loki-darwin-arm64"
      sha256 "PLACEHOLDER_ARM64_SHA256"
    else
      url "https://github.com/simonspoon/loki/releases/download/v0.1.0/loki-darwin-amd64"
      sha256 "PLACEHOLDER_AMD64_SHA256"
    end
  end

  def install
    binary = Dir["loki-*"].first || "loki"
    bin.install binary => "loki"
  end

  test do
    assert_match "Desktop app automation", shell_output("#{bin}/loki --help")
  end
end
