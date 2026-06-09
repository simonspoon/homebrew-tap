class Nyx < Formula
  desc "Index and search Claude Code conversation history"
  homepage "https://github.com/simonspoon/nyx"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.2/nyx-darwin-arm64"
      sha256 "e40fca81e8975d080f9990ff4ed57c5bf48be4a097519e40a1399f6d1d8a392d"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.2/nyx-darwin-amd64"
      sha256 "08c356f3f7489641f4c69a72b76f7d71a3f8b4f43c32a5719daa786552b9db27"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.2/nyx-linux-arm64"
      sha256 "18663a018e2766110d10e058d50d9ed4002a29b023da94152c446fcaea701515"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.2/nyx-linux-amd64"
      sha256 "94e29fde8301b6465df5974966a65e302289026dba9985adcb5f307569187360"
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
