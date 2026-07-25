class Loki < Formula
  desc "Desktop app automation CLI for macOS QA testing"
  homepage "https://github.com/simonspoon/loki"
  version "0.4.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/loki/releases/download/v0.4.0/loki-darwin-arm64"
      sha256 "466e057089d63944e973bb3be4dd0cef6e6a6ddbfaaac09d42209d3d72168cf6"
    else
      url "https://github.com/simonspoon/loki/releases/download/v0.4.0/loki-darwin-amd64"
      sha256 "6b19e7653a520d8e86cfbede4f4223e4ad9bceee8940e36cb94eb6c736855f9d"
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
