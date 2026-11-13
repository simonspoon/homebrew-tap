class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.31.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.31.0/naru-darwin-arm64"
      sha256 "ad875e357716efccf3fbe5c9a1c0e3a80b60545f25438e1ed4f82e58322f177d"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.31.0/naru-darwin-amd64"
      sha256 "acce48ed8a8c7de9983019cda3d9bac42a357f79da3fa3efe95867d1c4a3abc5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.31.0/naru-linux-arm64"
      sha256 "756068aed944b2d335f691036d8a31f7a419a8d76e99e0912e7adafc19d3414d"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.31.0/naru-linux-amd64"
      sha256 "f5cbc5c62eb4907b68443a014fee84ade1d2d9331889c2bba99781ca497addc8"
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
