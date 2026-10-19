class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.19.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.19.0/naru-darwin-arm64"
      sha256 "305e20c4ee90f1a095c62f6fb49e0faa2c6bdae00da49d7c9c4dc6b20b659df6"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.19.0/naru-darwin-amd64"
      sha256 "39c7af7ccacd84e335b1876c1945e90a6333d6a72362180465be3ee11dcfc3d0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.19.0/naru-linux-arm64"
      sha256 "35a9dd75bb04ad5d97bd15e1533e6dbdf1748a7d6a65f92d9be6f8dc8d9316ad"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.19.0/naru-linux-amd64"
      sha256 "cbeb5a849b2ab629a877ff256465cdd147ff6d3fc1ebadfcc1395f4546dda222"
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
