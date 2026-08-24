class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.34.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.34.0/helios-darwin-arm64"
      sha256 "b6abb74043ce499a2cd58ae3cd9a730b1871639598633d86a4d2fb157e0ab09d"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.34.0/helios-darwin-amd64"
      sha256 "4b90e25b389234182e480fca8367754a7a859a98f903590895df5b8680e25068"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.34.0/helios-linux-arm64"
      sha256 "e7bd0c2408cf4fa616be5b70f43622bd8172588a519c430c602ed918843b3051"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.34.0/helios-linux-amd64"
      sha256 "5f8b95ecc02f8b18645bc2845d96824a5156a3af17ed5be76db042aaef1ab38a"
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
