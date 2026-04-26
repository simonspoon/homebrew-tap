class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.3.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.7/simaris-darwin-arm64"
      sha256 "7194ade1c9d5f0ecd0ea143d0311dae52a9277bb58fb6c5cf93fe8167209cda1"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.7/simaris-darwin-amd64"
      sha256 "8420cd0ca5e64e1d84a081bc24edf33445a667f2046bd9b0e3fb3993e96bf9cd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.7/simaris-linux-arm64"
      sha256 "1b166559b1abd18d46af4cb4e68fd16726b7e862f5f10b866f6e52e505924f83"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.7/simaris-linux-amd64"
      sha256 "7aa6283af66b980af2a0ded9b944cb55a06fed5d5dfb767c8e1a25f751c9ab34"
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
