class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.15.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.15.0/naru-darwin-arm64"
      sha256 "43f45cf6746639d6f935547cef865fd0e9c5f1c76c0cbde1fe1abd3d73943ad1"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.15.0/naru-darwin-amd64"
      sha256 "7d3841158d3afad1f92fb03e6710ccbbedb05623b2104fa43748ecc4b613de6d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.15.0/naru-linux-arm64"
      sha256 "9d7a7488bf5fa0513174c6b0ad4f1b4894f514a22845e7736b4e5a08141006fe"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.15.0/naru-linux-amd64"
      sha256 "9c39d762d835c30353ab57611809d7ba26c15df9af47eac7de98971aacbd0ba6"
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
