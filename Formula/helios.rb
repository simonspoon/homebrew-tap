class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.45.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.45.0/helios-darwin-arm64"
      sha256 "dcb2267981136da586d7c39f70b7b596c37b140d90f7ee737a271ccf6f433278"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.45.0/helios-darwin-amd64"
      sha256 "d85a31338ec1c879e0a4276a3d105063b5be7da04442ad03bcd69f0593f79646"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.45.0/helios-linux-arm64"
      sha256 "d7714fe881efde1a1384bad169c6685045b403c4ffaa97f7865fecd4d768dbea"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.45.0/helios-linux-amd64"
      sha256 "105568cbf626fba273636ce376ecc5d208d8b9233f866de7022f24918e5343a7"
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
