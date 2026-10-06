class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.5.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.5.0/naru-darwin-arm64"
      sha256 "2eb285a56b261fa8910322c5c338b5d86e44ec5b18a07c2bf1fbb24538906fb4"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.5.0/naru-darwin-amd64"
      sha256 "1e35191f353ebb371260f82505bd48ca23960fd176dc235dbe12b3e3115f9991"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.5.0/naru-linux-arm64"
      sha256 "91d5e67f5b121e0b3707f12fb6a110bc80513236577f57ec747d677e2eca30df"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.5.0/naru-linux-amd64"
      sha256 "5ee047ec9502f8f49b4393a7442cde3643654cedeab07ece877f669453db64d4"
    end
  end

  def install
    binary = Dir["naru-*"].first || "naru"
    bin.install binary => "naru"
  end

  test do
    assert_match "naru", shell_output("#{bin}/naru --help")
  end
end
