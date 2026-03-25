class Loki < Formula
  desc "Desktop app automation CLI for macOS QA testing"
  homepage "https://github.com/simonspoon/loki"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/loki/releases/download/v0.1.0/loki-darwin-arm64"
      sha256 "7f72a6e1e5c197b0a26fbe18d46cb51264b8081bc8b468e6cdc6681a34b1b70d"
    else
      url "https://github.com/simonspoon/loki/releases/download/v0.1.0/loki-darwin-amd64"
      sha256 "f41f93ea10dad44b5f0dc2eeb742318127dd38d6fa89ea75c798383a09c9ba21"
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
