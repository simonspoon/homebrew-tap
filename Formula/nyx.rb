class Nyx < Formula
  desc "Index and search Claude Code conversation history"
  homepage "https://github.com/simonspoon/nyx"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.3/nyx-darwin-arm64"
      sha256 "c03d85bb1692cd27b8f94e87df0c097b4db8c8a8fdf69bdc86d9ecd0cab02e60"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.3/nyx-darwin-amd64"
      sha256 "e997c3cbc2265b2b2d7a54b995b83233ead89ccc07757b1f82d8717e8e8af512"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.3/nyx-linux-arm64"
      sha256 "5ad6c414abe1d15bdcbe87c08cb3354fefc06333a68d97eeb394538760cdb90f"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.3/nyx-linux-amd64"
      sha256 "28cfd1ce11e94df0191c88885e7378fedb8c80dc56551e178c2ed438a2a2a378"
    end
  end

  def install
    binary = Dir["nyx-*"].first || "nyx"
    bin.install binary => "nyx"
  end

  test do
    assert_match "nyx", shell_output("#{bin}/nyx --help")
  end
end
