class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.30.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.30.0/helios-darwin-arm64"
      sha256 "c2d239d4ccd3a1a2b6738b9d0cb0d3083e4a16bd4a363f699c48993126bf521c"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.30.0/helios-darwin-amd64"
      sha256 "7def93cb89d654d722e4170a7d23317596e5938a67eef6d2459071bc213ddb1d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.30.0/helios-linux-arm64"
      sha256 "a0c3716022ad4cbe6320a9d5dffafacb6b39fc1606bfb3c4b5a73c641ea2da2a"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.30.0/helios-linux-amd64"
      sha256 "b17d4c3e20dd1ced157514b33f0821c519b4a2cf27e2e586197d1c5f9302265a"
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
