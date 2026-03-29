class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.3.0/limbo-darwin-arm64"
      sha256 "2e3f30821af27d3fd3ccb7045e479a12c2f6c7899ea5316b79b91fc9493d68b5"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.3.0/limbo-darwin-amd64"
      sha256 "0e480f5e8bb576c6e57db1bfebb44e8eadc42523c8dce5b64eb1cf63a1e55a15"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.3.0/limbo-linux-arm64"
      sha256 "a4508dd7c197e60e9c1ecf0f72c88e91f24b98ce2b4d3f8a48c0f794332e4925"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.3.0/limbo-linux-amd64"
      sha256 "5b00fc7ff8c82724302a379f65c9a5b63dd976c1658f4aeda0370eb00612f66a"
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
