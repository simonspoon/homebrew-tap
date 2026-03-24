class Suda < Formula
  desc "Structured memory and knowledge management CLI for AI agent workflows"
  homepage "https://github.com/simonspoon/suda"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/suda/releases/download/v0.1.0/suda-darwin-arm64"
      sha256 "b0c82294f239b929d5d0e377107eab7780cbc4714a4bd06e822a99613185b3a8"
    else
      url "https://github.com/simonspoon/suda/releases/download/v0.1.0/suda-darwin-amd64"
      sha256 "6d359a2f69019b01dfcad55d0a3ac2a9b1d8c9355e4d06a4f317f23875a2c7a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/suda/releases/download/v0.1.0/suda-linux-arm64"
      sha256 "cb128a232235c9a2918d6f987895c6e5f51ce14ac4adbd8fca39809597a6f491"
    else
      url "https://github.com/simonspoon/suda/releases/download/v0.1.0/suda-linux-amd64"
      sha256 "db601c51a99cab62a26abd685edf7b9d09b57aed56f44fc3b74c438eec576325"
    end
  end

  def install
    binary = Dir["suda-*"].first || "suda"
    bin.install binary => "suda"
  end

  test do
    assert_match "suda", shell_output("#{bin}/suda --help")
  end
end
