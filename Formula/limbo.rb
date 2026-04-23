class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.8.0/limbo-darwin-arm64"
      sha256 "ec70382699d9156c49c1fe7d9213ddeca0179b006f9a581cba09f6ccbfbff2a1"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.8.0/limbo-darwin-amd64"
      sha256 "99e97f314775d2f27bd35fa9421a031621244b5b212ef9885a5382513cad87b9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.8.0/limbo-linux-arm64"
      sha256 "4fe5aac6d6a111855838b81054069ea1018f45139e527d21c3d2ef35221aec82"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.8.0/limbo-linux-amd64"
      sha256 "3228898e7a283e8d7c3ca93dcd04c300a43bf6ace5b2172328672f951268212d"
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
