class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.11.0/limbo-darwin-arm64"
      sha256 "52a5cd05d63d580824bcbcf7e742a9ae1a2e6c88d41d3344dd9b7c226d3589dc"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.11.0/limbo-darwin-amd64"
      sha256 "13e11751096d9a57e0717d310adfbbe4fe10fe8281a73d4e17dbf08228450bbe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.11.0/limbo-linux-arm64"
      sha256 "6b94cebfac977b25cba66cdba60093977420944424b989f7cd51405a65c1d04f"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.11.0/limbo-linux-amd64"
      sha256 "d7dcd8668d79b5426a466a7958b9df2f93d7658b09013d3de8340746ae040d85"
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
