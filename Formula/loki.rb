class Loki < Formula
  desc "Desktop app automation CLI for macOS QA testing"
  homepage "https://github.com/simonspoon/loki"
  version "0.5.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/loki/releases/download/v0.5.0/loki-darwin-arm64"
      sha256 "8b3534d4554a8b31b500bd69ee240c5a4ccc1d91ea479ba750c1862dae2a2939"
    else
      url "https://github.com/simonspoon/loki/releases/download/v0.5.0/loki-darwin-amd64"
      sha256 "bd8d14000373b5b4336a57c7593646e66a9c3331b34f80f16406275f068b18c4"
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
