class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.5.0/limbo-darwin-arm64"
      sha256 "9545ee79ebbd37eae92eee7a3340149dd80412663345a6106d80d7480003e006"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.5.0/limbo-darwin-amd64"
      sha256 "47aa9bb8b4472f2e78a1859a6e3026616d01d664bfae24ab96a3b4853a1b3fd9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.5.0/limbo-linux-arm64"
      sha256 "90a224c69f9300d83953dd603f73836eadb2b03fc20331fcc73c6a9de579b5be"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.5.0/limbo-linux-amd64"
      sha256 "9c4c430a0ba0abc13bc25d518abf802ce6b739dbc758fcc8421eaf0e7bade3e9"
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
