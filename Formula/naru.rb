class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.10.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.10.0/naru-darwin-arm64"
      sha256 "09a8a8d8403bbcf187917596f697feac2e5e9f6418c3c75e28a2cafa634ca7c9"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.10.0/naru-darwin-amd64"
      sha256 "4dfcddba2ad5690398e5087385b330ac1b1bcf8136d5c112a5b5a390f6e81b82"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.10.0/naru-linux-arm64"
      sha256 "3d4b8a77247ba11ad8ed58973c9d923055ee5e04e1b045ae5492f79f8424646c"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.10.0/naru-linux-amd64"
      sha256 "83dda39e278887c00f9b957b6414de37c707cb15b01a88aa520ee2ac096308aa"
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
