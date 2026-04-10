class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.2/khora-darwin-arm64"
      sha256 "422740cf397f185f930bf01719017a77c971ae64620608aeffebedba84b7df09"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.2/khora-darwin-amd64"
      sha256 "7c5b0654c78212870e9c57dc2b04a40e72c3412eb6e3fd0303912657121b7199"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.2/khora-linux-arm64"
      sha256 "b00cfdac11b712e8947992d43489408a1464b10077949df6023af47c2b79fffb"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.2/khora-linux-amd64"
      sha256 "9c2c57157d3a50cf4be922e0e2318db44628f69865b57461431822e7425307e3"
    end
  end

  def install
    binary = Dir["khora-*"].first || "khora"
    bin.install binary => "khora"
  end

  test do
    assert_match "Web app QA automation", shell_output("#{bin}/khora --help")
  end
end
