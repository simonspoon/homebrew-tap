class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.32.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.32.0/helios-darwin-arm64"
      sha256 "7b49369d5bf47437169e848161537460afbbec615d27a16d4f7407023151e337"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.32.0/helios-darwin-amd64"
      sha256 "5874425238baa42bce04a2fa414c76e851c037183b93bee5f3131b5bd2dd3bbf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.32.0/helios-linux-arm64"
      sha256 "5847126838bc14b6b341babdc64a56a4f87ea29b304bc3e44c93cbbbfe234575"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.32.0/helios-linux-amd64"
      sha256 "a8802963bf31f2135f2988957873b7aeea3f90abc04ca108924c7e280b2d3270"
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
