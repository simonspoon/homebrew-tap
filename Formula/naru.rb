class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.11.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.11.0/naru-darwin-arm64"
      sha256 "624b695e25b05194c323b79dc3006dbbe1975a5bd47d3e12b102b4c0c875b87b"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.11.0/naru-darwin-amd64"
      sha256 "5c1d4ce6f87a21b81d5f704fb43eb1d98e08a2768dfa28d79a50e4bfad8f3938"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.11.0/naru-linux-arm64"
      sha256 "e8b612a3dac64a960bd59772b7340adc01c22965951e3329c8573019e4c7be52"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.11.0/naru-linux-amd64"
      sha256 "2f6d42cd26c04b1a5ff4e6ad5a3fbf564c09ba1e86ef3ffe28b305c24ba60094"
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
