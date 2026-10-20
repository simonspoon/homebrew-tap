class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.20.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.20.0/naru-darwin-arm64"
      sha256 "85cb47e293d1d2b9da2ac12d2db83e12260a1f25c7a864437c6460df9b356a04"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.20.0/naru-darwin-amd64"
      sha256 "4257518b191ec8a9081de0fa1923a8d7f3bef92af5fa192a5b303cd4031117cf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.20.0/naru-linux-arm64"
      sha256 "b1d6fea9dd228a359de7cfec8ff692f67fd914095065a2523d27f90ac1fff20b"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.20.0/naru-linux-amd64"
      sha256 "14ea4566815c7454aaee09bc0cc2e007d13b3d8a0c5f3b840d69919bc5964c59"
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
