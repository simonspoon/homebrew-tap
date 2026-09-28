class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "1.12.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.12.0/naru-darwin-arm64"
      sha256 "2cc774d8bad485ddee16d996c68f7e3879ec1910b8cfe4f75e2c5c9cbc42f733"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.12.0/naru-darwin-amd64"
      sha256 "3b468f4edc7e07774839fb8d96071359a21431c28d205b0d9a2c9b827f2bea09"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.12.0/naru-linux-arm64"
      sha256 "c9ddabf8405cb19d033bf0e76e06f5033f328a5c101f7e81a84d5513b3bf1e22"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.12.0/naru-linux-amd64"
      sha256 "eaa19971856a4b1c407d48f8d1efeda34213004517e55b6920aba3a71b6549b5"
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
