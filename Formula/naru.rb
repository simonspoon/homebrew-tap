class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.25.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.25.0/naru-darwin-arm64"
      sha256 "3c0ab8a2c1daf59901d3c5fa373c8e935912f48747045fa05e65120f877932c6"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.25.0/naru-darwin-amd64"
      sha256 "a24701e80b8885446101e2f879fad7b7caf0396bb418d6faf7e1834c30543439"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.25.0/naru-linux-arm64"
      sha256 "40f47b718a326d483c55adcf9ddaa4a3d26b66ce4b7a7769f97be452f0fc163e"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.25.0/naru-linux-amd64"
      sha256 "b6731d414665670db20dc3aff62fe57a4cc82ca6080459cc990457775fd99a13"
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
