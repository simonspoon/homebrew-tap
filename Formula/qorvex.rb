class Qorvex < Formula
  desc "iOS Simulator and device automation toolkit for macOS"
  homepage "https://github.com/simonspoon/qorvex"
  version "0.3.1"
  license "MIT"

  depends_on :macos
  depends_on :xcode

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-arm64.tar.gz"
      sha256 "3b62c0b75f3d3fd15b07ee728c57e1619d0ad1479d0c221df4fec183585ac58c"
    else
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-x86_64.tar.gz"
      sha256 "2be18ee70ca3012ba1b4b20b6be3071caa8d5453e2a83a945daff926ffb572ad"
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
