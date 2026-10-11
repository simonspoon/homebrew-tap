class Qorvex < Formula
  desc "iOS Simulator and device automation toolkit for macOS"
  homepage "https://github.com/simonspoon/qorvex"
  version "0.6.1"
  license "MIT"

  depends_on :macos
  depends_on :xcode

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-arm64.tar.gz"
      sha256 "fe8a4925f55a2547e4b247d5b3c371878f86973f3e335381881181695ed94385"
    else
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-x86_64.tar.gz"
      sha256 "d7991e1bde34083190ad007ffd647bfa865c4870f1971722d8ddd635403936b7"
    end
  end

  def install
    bin.install "qorvex"
    bin.install "qorvex-server"
    bin.install "qorvex-repl"

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
