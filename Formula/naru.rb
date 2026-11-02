class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.24.1"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.24.1/naru-darwin-arm64"
      sha256 "400ca93b8a0e1b7f1d59d808da1c6df311200382562d4e0cb37791b752e697b5"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.24.1/naru-darwin-amd64"
      sha256 "90ff3241b159550b0b35559400a0d6d43e80526de2a792b6a666e67d2d4c47f4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.24.1/naru-linux-arm64"
      sha256 "338833af3cf6c0776e9242c7776c7a2340eac785a5d3dac77360f1b9d1036f6b"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.24.1/naru-linux-amd64"
      sha256 "21d08781e65890d5ee33d3dbffa545254b7f916b09214fdaf7c5211273308a73"
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
