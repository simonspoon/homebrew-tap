class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.16.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.16.0/naru-darwin-arm64"
      sha256 "8c815d2b8c26517852fd8341ba26f2daae27eecb5d5e873b47b49a1e033adcd0"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.16.0/naru-darwin-amd64"
      sha256 "7a1054d02cd7388421b4c6b2128007de2eb02f40c1bae7a64cfd52dbdcd98cfd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.16.0/naru-linux-arm64"
      sha256 "930c6035ebc4e0ef203a31305c85cd3994eef4ac133c388f0901d517d18ec209"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.16.0/naru-linux-amd64"
      sha256 "3ecd721bf7435ab0e59876175cb8aa8cba160d33b86e3f521cabeb280470581f"
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
