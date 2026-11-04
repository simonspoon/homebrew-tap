class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.26.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.26.0/naru-darwin-arm64"
      sha256 "106e2faa8db44208ff685b4ce68793998b1264a2454f4e180de3afae69871f00"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.26.0/naru-darwin-amd64"
      sha256 "9dd5e09ba410046d940eeec7a5715dec8ad0c8b94995b8fae13369f78b9fbbf9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.26.0/naru-linux-arm64"
      sha256 "809a2be2b2d33b444c01a5396a08f9c475bdda45411e8d2523cf32fb5bf1e24a"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.26.0/naru-linux-amd64"
      sha256 "b85e41b6ece84ccef0431d37f473a5385f10fef376221a07db888e974b1d21e4"
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
