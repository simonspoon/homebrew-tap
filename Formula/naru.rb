class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.23.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.23.0/naru-darwin-arm64"
      sha256 "14a34bb16dde00cfd69e38e76930f6cfb9a0784d3a50ad2514ead5993a0c4eac"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.23.0/naru-darwin-amd64"
      sha256 "a5b1e1cb7916d829e24d40cbadf66cd15e8b98f4950175ced463f5cf3f959965"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.23.0/naru-linux-arm64"
      sha256 "64ecbdee39a70932a9cca5622586b511aba0fbbdc198e96558e08e92d5ec1d41"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.23.0/naru-linux-amd64"
      sha256 "86ac0fe63c6ff3ca28c332b3603555da9a93d53f2472fa7d7e9535ea692d4e53"
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
