class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.13.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.13.0/naru-darwin-arm64"
      sha256 "4d1d459eb6d4e99db403971c0ebe1a0d4b6ca10fbad0fac7d29d5135484c2492"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.13.0/naru-darwin-amd64"
      sha256 "6e104e9cd7b9e28ff41d6828d351b806f068063b52208e95bf27a2438bbd6762"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.13.0/naru-linux-arm64"
      sha256 "447dc53deba990e08e863333048d32ff6d9d2551db0ba91bdddd2fe2e0b2c78e"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.13.0/naru-linux-amd64"
      sha256 "21cf592424db7c5b47e4eeb939398e3c0b7d745b46f56d67e9f958456dbcb327"
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
