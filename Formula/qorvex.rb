class Qorvex < Formula
  desc "iOS Simulator and device automation toolkit for macOS"
  homepage "https://github.com/simonspoon/qorvex"
  version "0.2.13"
  license "MIT"

  depends_on :macos
  depends_on :xcode

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-arm64.tar.gz"
      sha256 "fd430d189ad00c19b9db91e532a31760bc0cc3d00d9c5005919c314ff8d0856d"
    else
      url "https://github.com/simonspoon/qorvex/releases/download/v#{version}/qorvex-macos-x86_64.tar.gz"
      sha256 "29b2687e1d90bf03a3f753761c87e244c16bdfcae3491fa11923a64eb8fd4103"
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
