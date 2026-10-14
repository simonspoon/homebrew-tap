class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.12.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.12.0/naru-darwin-arm64"
      sha256 "ab6e18c4ca21926bba35adc4ca6e71fbad50727bc6d068fddd27eb702cab0ecf"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.12.0/naru-darwin-amd64"
      sha256 "f568476d37027ac8f9030c994df77dee2799621b513500533bd1df41ac2c3dbb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.12.0/naru-linux-arm64"
      sha256 "8da5c9aee0e73b96da47035825786fb452c74048cb2d4ca961f212f3731851f6"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.12.0/naru-linux-amd64"
      sha256 "97d35e7e5d405f01cf7f595f4cd238418b08cf5baa7c735cff5e03cfe60fb9a6"
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
