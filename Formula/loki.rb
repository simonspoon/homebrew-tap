class Loki < Formula
  desc "Desktop app automation CLI for macOS QA testing"
  homepage "https://github.com/simonspoon/loki"
  version "0.2.1"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/loki/releases/download/v0.2.1/loki-darwin-arm64"
      sha256 "4aad59d5dc863cba140c3fc3654e29ab93878e8d0de22a4a8eea3c95a25027f6"
    else
      url "https://github.com/simonspoon/loki/releases/download/v0.2.1/loki-darwin-amd64"
      sha256 "a5b1177e7a9c22d587c3fbd07963a63292c59a05e3526f27f5e66bfb49a94a5a"
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
