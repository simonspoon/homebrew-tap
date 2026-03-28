class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.2.0/limbo-darwin-arm64"
      sha256 "4ca9f84950f1f06f58a18e7f7028db08fa3de61515581c9262f4ee13a21f338b"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.2.0/limbo-darwin-amd64"
      sha256 "1170f6add3e7ba6e22a28bea8358bf079662d65979b294056986de93892bc2eb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.2.0/limbo-linux-arm64"
      sha256 "ada5bae5c9248ccc4704502ae43692307b5a922daffde4d1e1502d0cabf9520d"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.2.0/limbo-linux-amd64"
      sha256 "09cfff0c55b7395cf42b7bfcfd967a93a1c0faeca226a5e9334cba5fc6337781"
    end
  end

  def install
    binary = Dir["limbo-*"].first || "limbo"
    bin.install binary => "limbo"
  end

  test do
    assert_match "limbo", shell_output("#{bin}/limbo --help")
  end
end
