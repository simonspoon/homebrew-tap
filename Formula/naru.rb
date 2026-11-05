class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.27.1"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.27.1/naru-darwin-arm64"
      sha256 "d4d63355ec921cde29ad98f8e6fc485c11a60272e38086d8392009ce1c2f9444"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.27.1/naru-darwin-amd64"
      sha256 "f2e8ee79c4f7e87353f22e6ac436b3128cbd44361881f905a5eece844888221d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.27.1/naru-linux-arm64"
      sha256 "9dca84031a2829c1ab8d173850fbfa33372617427e087994732735a5a8b43448"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.27.1/naru-linux-amd64"
      sha256 "46564ac6ba3b7c04008e9e36e2c1e8b0a5a4b4d706f97d7ac7e75c599bee6dbc"
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
