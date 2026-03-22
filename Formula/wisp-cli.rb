class WispCli < Formula
  desc "CLI companion for Wisp, a desktop UI design tool for agents"
  homepage "https://github.com/simonspoon/wisp"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/wisp/releases/download/v0.1.0/wisp-cli-darwin-arm64"
      sha256 "d5b78be40ed1a0262967a28e8b154296f1560eb439db90f0c0a7045065c9751e"
    else
      url "https://github.com/simonspoon/wisp/releases/download/v0.1.0/wisp-cli-darwin-amd64"
      sha256 "a3537850348e68a95f86ee0341ea9dae40da0f07776e5e26cafc3bd2192888bc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/wisp/releases/download/v0.1.0/wisp-cli-linux-arm64"
      sha256 "8450fa15d6174fe0e786e4540e13df3f5200f4ce045fbb502da98f0155860aaa"
    else
      url "https://github.com/simonspoon/wisp/releases/download/v0.1.0/wisp-cli-linux-amd64"
      sha256 "939862dccd9215425b3821497cc41287ff9c19acd150f6960187d584f937af1a"
    end
  end

  def install
    binary = Dir["wisp-cli-*"].first || "wisp-cli"
    bin.install binary => "wisp-cli"
  end

  test do
    assert_match "wisp", shell_output("#{bin}/wisp-cli --help")
  end
end
