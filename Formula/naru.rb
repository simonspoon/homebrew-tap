class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.30.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.30.0/naru-darwin-arm64"
      sha256 "05aba43d8db02a11dbf08ac81cbf9f10cde491425aa94f4e102bdc3eec0f6f10"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.30.0/naru-darwin-amd64"
      sha256 "90b94ec7f751c36ffc920e6a3c818cc313b843d24f1af7cae595dad8d9742488"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.30.0/naru-linux-arm64"
      sha256 "24be203b950ad95454926052745c93d502d29fc674da4fe06582e3e861cf7f51"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.30.0/naru-linux-amd64"
      sha256 "cbf36a58b0146b3dad1c074a59f6e088dbb7b4ad010d516511d33fd5682901cd"
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
