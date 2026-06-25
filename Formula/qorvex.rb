class Qorvex < Formula
  desc "iOS Simulator and device automation toolkit for macOS"
  homepage "https://github.com/simonspoon/qorvex"
  version "0.2.3"
  license "MIT"

  depends_on :macos
  depends_on :xcode

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-arm64.tar.gz"
      sha256 "211f65e27d2a9876a181c4eeb4e319599f73676a3647486d44316c42a1412d9a"
    else
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-x86_64.tar.gz"
      sha256 "139bf002b90ff2a97d09c0764f64ebb60d55f143568d77bbdd6a217c61d1b280"
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
