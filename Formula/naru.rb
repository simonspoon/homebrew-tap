class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.28.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.28.0/naru-darwin-arm64"
      sha256 "8afba4a622e1b4e4045e2f1d8d3beee7dd4d2e78acc4a6f933e50e1e1ed92796"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.28.0/naru-darwin-amd64"
      sha256 "b03397fcca9c99874eba7da4487202aa7f22c2dd66b5994f1ff4937b45a0937c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.28.0/naru-linux-arm64"
      sha256 "bc33f30620fcba5d603e3a79353d6cc5100d76a5930f17d880c165ef36488d8a"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.28.0/naru-linux-amd64"
      sha256 "8db7cbea6162f0f620fd917ae416c6bfe5f179fd2669c2580ccbd93b78791b9a"
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
