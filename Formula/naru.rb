class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.29.1"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.29.1/naru-darwin-arm64"
      sha256 "cb5de786d1519dda7dd76826ffc8430634ab9c07930e4d432ddbf04848d7b1d7"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.29.1/naru-darwin-amd64"
      sha256 "dfcfe0ea53c2fbf0568d49f9ae4a3b82b7874e73790b999b6f8c5117a6d5b008"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.29.1/naru-linux-arm64"
      sha256 "72194584e7b3aa8a05b6eb3934b1e6677a4125615223ce3efdaa81e88a509107"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.29.1/naru-linux-amd64"
      sha256 "26db1f7479f7769e8df3936c57bc13acb3eb72ab31427d6dc8e66c02e39a0f3c"
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
