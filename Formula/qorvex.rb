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

  def post_install
    agent_dir = share/"qorvex/agent"
    xcodeproj = agent_dir/"QorvexAgent.xcodeproj"
    return unless xcodeproj.exist?

    ohai "Building qorvex-agent for iOS Simulator..."
    system "xcodebuild", "build-for-testing",
           "-project", xcodeproj,
           "-scheme", "QorvexAgentUITests",
           "-destination", "generic/platform=iOS Simulator",
           "-derivedDataPath", agent_dir/".build",
           "-quiet"
  end

  def caveats
    <<~EOS
      The Swift agent was built for iOS Simulator during installation.

      To build for physical devices (requires Apple Developer account):
        xcodebuild build-for-testing \\
          -project #{share}/qorvex/agent/QorvexAgent.xcodeproj \\
          -scheme QorvexAgentUITests \\
          -destination "generic/platform=iOS" \\
          -derivedDataPath #{share}/qorvex/agent/.build \\
          DEVELOPMENT_TEAM=<your-team-id> \\
          CODE_SIGN_STYLE=Automatic \\
          CODE_SIGN_IDENTITY="Apple Development" \\
          CODE_SIGNING_ALLOWED=YES \\
          -allowProvisioningUpdates
    EOS
  end

  test do
    assert_match "qorvex", shell_output("#{bin}/qorvex --help")
  end
end
