class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.22.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.22.0/naru-darwin-arm64"
      sha256 "86b3a9521e83a36fbdbedae9566afa0e33cda9caa6a476919e0d2234f103719b"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.22.0/naru-darwin-amd64"
      sha256 "3ab86504da42ed73d3c0d65c2193c25a9b83459da7f1794b4d9b22c84904f256"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.22.0/naru-linux-arm64"
      sha256 "34c96a144a5689df38a867a8d298baa7cd494aae64aeb7fc242f40b4c41af87d"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.22.0/naru-linux-amd64"
      sha256 "8717a135ef8031de21ae751a71fccc9ce223c76825428c28e105e7fd3a8ad1ac"
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
