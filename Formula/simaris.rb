class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.1.0/simaris-darwin-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.1.0/simaris-darwin-amd64"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.1.0/simaris-linux-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.1.0/simaris-linux-amd64"
      sha256 "PLACEHOLDER"
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
