class Loki < Formula
  desc "Desktop app automation CLI for macOS QA testing"
  homepage "https://github.com/simonspoon/loki"
  version "0.3.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/loki/releases/download/v0.3.0/loki-darwin-arm64"
      sha256 "46d58f7bc2d842912bdde663b670bb7cc8e9048636746ed230bd9054926de0ff"
    else
      url "https://github.com/simonspoon/loki/releases/download/v0.3.0/loki-darwin-amd64"
      sha256 "f0aa7084dd0c192675c47aedd87c5d097632c32f8f79dfbbbe1ee44f8ff0a894"
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
