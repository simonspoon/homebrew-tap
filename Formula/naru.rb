class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.20.1"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.20.1/naru-darwin-arm64"
      sha256 "5a1464350106a1e8bb75ef26e6db49b32a38bdb4303e66507569ad5f0f4b5040"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.20.1/naru-darwin-amd64"
      sha256 "99f5175eb7938d4e6c2f59eca87fac5027f24070dcc41b0797cee17c020c4d2c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.20.1/naru-linux-arm64"
      sha256 "24fc2520d51efba3df25be2f50cd60558a145ada44f43e553918bc2d295021bc"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.20.1/naru-linux-amd64"
      sha256 "e955c4d046ffc89d31317ae21c69ef1a9d4040fc150d65fae89b66bfd5e7f684"
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
