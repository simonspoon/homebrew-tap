class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.14.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.14.0/naru-darwin-arm64"
      sha256 "a146400aac6f9f2608721d232ba04c9d99af48ed7312ed31b57f7f78c3c59cf5"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.14.0/naru-darwin-amd64"
      sha256 "8790d2805281e942d05d5cfacad1e51bb5c0f73638f0036e0b26cc2fe013b002"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.14.0/naru-linux-arm64"
      sha256 "49e0c329d9eabebb46f39e55191043c88f1c1b7cae410efe5180d847cfac9984"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.14.0/naru-linux-amd64"
      sha256 "5b454fb5030356777d1feac8de0b0c20881b355fd9dafe33dc5c55abe2fddb51"
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
