class Qorvex < Formula
  desc "iOS Simulator and device automation toolkit for macOS"
  homepage "https://github.com/simonspoon/qorvex"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/qorvex/releases/download/v0.1.0/qorvex-macos-arm64.tar.gz"
      sha256 "1995e708be3edf283d8e25ba50ae35a1dd5ed6c7371576968fb0944cdd47c235"
    else
      odie "qorvex is only available for Apple Silicon (arm64) Macs."
    end
  end

  def install
    bin.install "qorvex"
    bin.install "qorvex-server"
    bin.install "qorvex-repl"
    bin.install "qorvex-live"
    bin.install "qorvex-streamer"
  end

  test do
    assert_match "qorvex", shell_output("#{bin}/qorvex --help")
  end
end
