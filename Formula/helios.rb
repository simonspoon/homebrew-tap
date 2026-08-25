class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.43.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.43.0/helios-darwin-arm64"
      sha256 "617d688458aa6e822f5e0a85da7bf9e39e5d938052267f5e27b3171f63827931"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.43.0/helios-darwin-amd64"
      sha256 "28143cb6f09c303d58fdbc977b088e1b80cb234a60453af0ae408d36ba83c6bc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.43.0/helios-linux-arm64"
      sha256 "2c2c07c74d4cb5257d1fd0125de39c695580541f99d5aaccd123129577c44a5c"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.43.0/helios-linux-amd64"
      sha256 "0289d4cf30f48e907f95f74586b666edc429faa2b2b23c0e953fd617b40e28e0"
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
