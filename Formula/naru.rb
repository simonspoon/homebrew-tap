class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.18.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.18.0/naru-darwin-arm64"
      sha256 "c7cc1b5eb8a67a99978c4cebe1998e005e4e74ae830f30e2b9c6b5d9d7350d21"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.18.0/naru-darwin-amd64"
      sha256 "aa0d13ef591b15b5c754740e1966a07b729fc4a299f5b5f4131c8609483f66d0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.18.0/naru-linux-arm64"
      sha256 "f7ba859f339b7d1d99874f513a7c0e514235f015dedd1464425bc809b58982ab"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.18.0/naru-linux-amd64"
      sha256 "9543c8b4036079bbd102bde350527510b16c4123bfac8f051439e4881c708811"
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
