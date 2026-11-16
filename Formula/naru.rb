class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.32.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.32.0/naru-darwin-arm64"
      sha256 "2c02545f2c20f45bdb089d00ef020025a6854a7c4e5419179b2317527ded37bb"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.32.0/naru-darwin-amd64"
      sha256 "afcf477cf12d33f38e19d227204906194d0377dfd6f6df1caa13afe05717e13c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.32.0/naru-linux-arm64"
      sha256 "e42e91e2c1def1142d3f55e17234b79a8e264a002a83a3e60575ad2d2fc0bae0"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.32.0/naru-linux-amd64"
      sha256 "a8670e810b799558a58b1e91aed8a5be70291c8906f4f2e5933806e5900c7ba7"
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
