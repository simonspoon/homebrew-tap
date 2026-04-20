class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.0/simaris-darwin-arm64"
      sha256 "9ccb1b33fc6cb6b86c23fc7a4c9e6593ba303f963c4ac72f6913fc29bc244464"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.0/simaris-darwin-amd64"
      sha256 "c15a9ff22683d1e21508343953d29e780ca4e51417be8b01e01576565bfa1284"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.0/simaris-linux-arm64"
      sha256 "c9aee424292162ba70328afde59d847888e07ba51b30448317e377bf5c307a98"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.0/simaris-linux-amd64"
      sha256 "9152010c3d072b1b5fb1e4f260d8a700d3dc0c5ac8f2a5186cf3b7537798aba1"
    end
  end

  def install
    binary = Dir["simaris-*"].first || "simaris"
    bin.install binary => "simaris"
  end

  test do
    assert_match "simaris", shell_output("#{bin}/simaris --help")
  end
end
