class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.12.0/helios-darwin-arm64"
      sha256 "c0776db2e4f5cd968b88a08869236a0e93ee7bc317a4716a5e735039a8c0eb64"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.12.0/helios-darwin-amd64"
      sha256 "618d1d0d0f74a305596a62430f13fe93e66b36983f78f4f92927155b0ea80d08"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.12.0/helios-linux-arm64"
      sha256 "97b21863a8ddb4d25d20cdf013b0c5d095b96ef755a7f0b05f7bbf4178770ec7"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.12.0/helios-linux-amd64"
      sha256 "c97eedc2e01e397b8448a2e2c6657b14ab2df796c047e7aa23f89684007a1bfe"
    end
  end

  def install
    binary = Dir["helios-*"].first || "helios"
    bin.install binary => "helios"
  end

  test do
    assert_match "helios", shell_output("#{bin}/helios --help")
  end
end
