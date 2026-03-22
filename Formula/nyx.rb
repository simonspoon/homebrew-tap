class Nyx < Formula
  desc "Index and search Claude Code conversation history"
  homepage "https://github.com/simonspoon/nyx"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.1.0/nyx-darwin-arm64"
      sha256 "ba962ea8b16842750815acd46b4da8f550e51c3157914d4c179b43714327c61f"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.1.0/nyx-darwin-amd64"
      sha256 "41762bd722629a9fcf43ca7917458ff4a60926f66304559cda1e2a3e0e33dc47"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.1.0/nyx-linux-arm64"
      sha256 "c50f48b096679e3259003c9bdc543b5a3b003beb25b7491dc085c28ef3702a1f"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.1.0/nyx-linux-amd64"
      sha256 "7a1e01062e43f998cfc13a6097124698349cf0771e0d2cdb9243603e4021fe8b"
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
