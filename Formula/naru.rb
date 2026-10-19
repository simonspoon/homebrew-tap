class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.17.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.17.0/naru-darwin-arm64"
      sha256 "6a5f2a96584a0c5571792d7d38b9103867dcaa89e8f02d19f172b1be2ab5aa9d"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.17.0/naru-darwin-amd64"
      sha256 "3bf47c7fea9f185c9f88d0ff0b68cc345a77fbf322c06593e5322d247fe730bd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.17.0/naru-linux-arm64"
      sha256 "7898c4c1eee44bd7283813e9c6b6d8f6fdf0868fe54b5b3d8e031ced1193aeac"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.17.0/naru-linux-amd64"
      sha256 "1556fc229e230a50e9159b29ff7bd8e35f8a7baa2980587356b10a7bab19ca0a"
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
