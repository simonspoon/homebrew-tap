class Qorvex < Formula
  desc "iOS Simulator and device automation toolkit for macOS"
  homepage "https://github.com/simonspoon/qorvex"
  version "0.2.8"
  license "MIT"

  depends_on :macos
  depends_on :xcode

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-arm64.tar.gz"
      sha256 "fb036049a142da87982ba061559fdef479f7fa17e2bbf44b138a8dd272cc18f4"
    else
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-x86_64.tar.gz"
      sha256 "c60a188134dd43bd39972cb3f840c3abf8340f1def5a1b4c40d2c633b900e259"
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
