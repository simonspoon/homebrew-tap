class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.10.1"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.10.1/naru-darwin-arm64"
      sha256 "5e3352e4826fe1aea8a7fe8aa63c8be861001649bdf5aa68a5069e54f212c686"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.10.1/naru-darwin-amd64"
      sha256 "c47d283da5ed3749bef254e8d2efac7143634b00401368d3c6079bec21eb1490"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.10.1/naru-linux-arm64"
      sha256 "7e2add51dad2a0f3d93542efd9a7bee0139d6a9a9642ea1706178b7bae6d0f0b"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.10.1/naru-linux-amd64"
      sha256 "3fdcb99bb78fa506e23a4bd770dbfd264a77f0d617fd45e9355161051c80c8c4"
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
