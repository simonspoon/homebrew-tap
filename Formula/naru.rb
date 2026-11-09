class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.29.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.29.0/naru-darwin-arm64"
      sha256 "e355f6c616ca4b0540a56f0231bdb6bd99e01efaebc5f486814040da76b47bb2"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.29.0/naru-darwin-amd64"
      sha256 "66649ffab64bc7cc971801a930a7f6834bd6cdd663c987e399c1243cd9f72f37"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.29.0/naru-linux-arm64"
      sha256 "9dc4345b74b4a87b86834af753564bd3ec3ef5fd130cf0d74410ec19a68c252d"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.29.0/naru-linux-amd64"
      sha256 "8ac3ec2fc9a470ddc658f0ce6b9fe3b01c6696c41dd4a38e1b39fd1543b0b688"
    end
  end

  def install
    binary = Dir["naru-*"].first || "naru"
    bin.install binary => "naru"
  end

  def caveats
    <<~EOS
      Run Naru as a background service:
        brew services start naru
      then open http://127.0.0.1:7770
    EOS
  end

  service do
    run [opt_bin/"naru", "serve"]
    keep_alive true # the UI restart exits 0 after spawning a child; launchd reaps it, so relaunch
    working_dir Dir.home
    log_path var/"log/naru.log"
    error_log_path var/"log/naru.log"
    # launchd's PATH lacks claude (~/.local/bin); agents are spawned by name.
    environment_variables PATH: "#{Dir.home}/.local/bin:#{std_service_path_env}"
  end

  test do
    assert_match "naru", shell_output("#{bin}/naru --help")
  end
end
