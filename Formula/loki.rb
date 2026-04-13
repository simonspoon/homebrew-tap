class Loki < Formula
  desc "Desktop app automation CLI for macOS QA testing"
  homepage "https://github.com/simonspoon/loki"
  version "0.2.2"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/loki/releases/download/v0.2.2/loki-darwin-arm64"
      sha256 "262957e635825a9d0c10eb48606dc3c71b8fccb8e742fe5196b4783a8388b518"
    else
      url "https://github.com/simonspoon/loki/releases/download/v0.2.2/loki-darwin-amd64"
      sha256 "974da78fad6cc9fab1c03265d63bb128118b517812a336dfde92c82b7b2432dc"
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
