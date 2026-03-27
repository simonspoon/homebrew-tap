class Loki < Formula
  desc "Desktop app automation CLI for macOS QA testing"
  homepage "https://github.com/simonspoon/loki"
  version "0.2.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/loki/releases/download/v0.2.0/loki-darwin-arm64"
      sha256 "1fed365f0c8051e87c6a8628eb6c5d87fcae3b38fb10447c3ebb70047288e422"
    else
      url "https://github.com/simonspoon/loki/releases/download/v0.2.0/loki-darwin-amd64"
      sha256 "5bf7d61cd9ded4d9e4a4ddf1da1be74b076f60711133f0f20944e5cdc7e6f61f"
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
