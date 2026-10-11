class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.9.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.9.0/naru-darwin-arm64"
      sha256 "87da73f0b2fb47ac2562c6755cbe88bba83b606d49db42710f062bc75d778c05"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.9.0/naru-darwin-amd64"
      sha256 "3cdf3a7c94f5e6d958dfeb26c67662ce1ad554b72f0d434db2ec0f61baa12416"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.9.0/naru-linux-arm64"
      sha256 "190ff4e3cc45d6f2933c8499d587fe567bc616686fa54324796d4baef2640bab"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.9.0/naru-linux-amd64"
      sha256 "56f9bbbca56e4e8b52091b7c55118d966d21b5659a5094cea6a94ca0ffc0cbcb"
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
