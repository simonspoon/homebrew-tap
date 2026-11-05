class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.27.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.27.0/naru-darwin-arm64"
      sha256 "2c1569ef2cabec480376ac9dba71146e07b10a1f3ebb007187ad80e72f205d40"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.27.0/naru-darwin-amd64"
      sha256 "7e94baec70f659aa08d6387bf3818aaf1bc7933557c315d26335548028ca150e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.27.0/naru-linux-arm64"
      sha256 "cc670cb22b66af5c251933a341dc3f9022b9ad1171940cf19b19a4ffb1d183a6"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.27.0/naru-linux-amd64"
      sha256 "d58db4fa3caf8bf90438a3c87817f7a29dbfc0be4d5e77e6840cc9f5aa398024"
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
