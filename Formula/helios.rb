class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.3.0/helios-darwin-arm64"
      sha256 "e3d9c8ba49b0a6fb28ffe6ffdc47a35ecacc7b90393ae47a7df728c40f1c564a"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.3.0/helios-darwin-amd64"
      sha256 "5be7dbb90926347fefc1e483a279272626caaa23f0c424adfffc382265459aa1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.3.0/helios-linux-arm64"
      sha256 "37e92fe593145e53f527582d3814773a88ad5f84de7dc3d54057dae7ea982087"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.3.0/helios-linux-amd64"
      sha256 "c7581bca3b1fbae99982e7bdd1bcf9d8007c3a9403c0663f1ea9f994641015dd"
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
