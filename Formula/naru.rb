class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.24.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.24.0/naru-darwin-arm64"
      sha256 "732e5f1368a3fce41935f8c4020e4e7d5b2ae724d6578d84b101f9aee52ca578"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.24.0/naru-darwin-amd64"
      sha256 "134f620f19cb5a153a29d77f7c91726efe079b3e0a3992088f5d6971c1140b39"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.24.0/naru-linux-arm64"
      sha256 "563800ae59ee7d7270ebb8ee5dfd98b3b2e3522c6cc35248835fb035e7c47a42"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.24.0/naru-linux-amd64"
      sha256 "43136170f0e5331cc6fa1b2931ad55b1e0ef071e1101f3c809f8f95cd418f78d"
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
