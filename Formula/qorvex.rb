class Qorvex < Formula
  desc "iOS Simulator and device automation toolkit for macOS"
  homepage "https://github.com/simonspoon/qorvex"
  version "0.3.0"
  license "MIT"

  depends_on :macos
  depends_on :xcode

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-arm64.tar.gz"
      sha256 "0ee70f7408896168cf6dbdc843a9ab4411784b76a8fb9e72dd39982b4359e252"
    else
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-x86_64.tar.gz"
      sha256 "72d383def251a9dd63f56e6ff7378071d437efa1fd3a49d20c8014da14f062bf"
    end
  end

  def install
    bin.install "qorvex"
    bin.install "qorvex-server"
    bin.install "qorvex-repl"
    bin.install "qorvex-live"
    bin.install "qorvex-streamer"

    (share/"qorvex/agent").install Dir["agent/*"]
    (share/"qorvex/agent-android").install Dir["agent-android/*"]
  end

  def caveats
    <<~EOS
      The iOS agent source is installed at #{share}/qorvex/agent.
      It builds and deploys automatically on first use (requires Xcode).

      The Android agent source is installed at #{share}/qorvex/agent-android.
      It builds and deploys automatically on first use (requires a JDK and the
      Android SDK with `adb` on PATH or ANDROID_HOME set).
    EOS
  end

  test do
    assert_match "qorvex", shell_output("#{bin}/qorvex --help")
  end
end
