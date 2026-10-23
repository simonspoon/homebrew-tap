class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.21.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.21.0/naru-darwin-arm64"
      sha256 "32c8b61be154ed09d6f750c90350ab372490c5ac43ed13b5ed59719f7acee6d1"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.21.0/naru-darwin-amd64"
      sha256 "17d526b657a53aeaab27a438d0597b297c7db39c55c733befd206b13579af5db"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.21.0/naru-linux-arm64"
      sha256 "87e59ec2033beb7680c74db00ac787dda8887ae98aeadd625d4560ca84cf4266"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.21.0/naru-linux-amd64"
      sha256 "3e8a88ad13391df7d9fafc9881a98cd7cdaccc35f4e3d14c1320333af7758a48"
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
