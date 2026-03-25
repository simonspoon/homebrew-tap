class Qorvex < Formula
  desc "iOS Simulator and device automation toolkit for macOS"
  homepage "https://github.com/simonspoon/qorvex"
  version "0.2.1"
  license "MIT"

  depends_on :macos
  depends_on :xcode

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/qorvex/releases/download/v0.2.1/qorvex-macos-arm64.tar.gz"
      sha256 "863003d13ffe1302fb3afcd8d4161e0578ade57196a21d627b0d20244a31fb05"
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

    (share/"qorvex/agent").install Dir["agent/*"]
  end

  def caveats
    <<~EOS
      The agent source is installed at #{share}/qorvex/agent.
      It builds and deploys automatically on first use.
    EOS
  end

  test do
    assert_match "qorvex", shell_output("#{bin}/qorvex --help")
  end
end
