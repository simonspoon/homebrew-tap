class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.5.0/helios-darwin-arm64"
      sha256 "5ba4d6bb0e078a96eb1aadf9876d9c4c9a79ec51e4aac08b5b29e4e8bed1c7fa"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.5.0/helios-darwin-amd64"
      sha256 "06ac1f943320dfe08f37ee649f5377fda54286cdc9de8115f82efc73a92b44cb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.5.0/helios-linux-arm64"
      sha256 "2a8d23b9b9f820b52c02a17b2c3a2150ac482689acff62af57c61b11c436090b"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.5.0/helios-linux-amd64"
      sha256 "61c7292804c4ce7308cd4fcf31955403ea84d3c717f0f653d196b1ee6e4ce593"
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
