class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.8.0/helios-darwin-arm64"
      sha256 "cd9522a05010777d74050999d3085f761a68d8b3c1c89fecbca311962230495c"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.8.0/helios-darwin-amd64"
      sha256 "454f0c0d09eac819ebc42f4e46d401f738abe9fa3c727bd0bbd50fab480b83c6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.8.0/helios-linux-arm64"
      sha256 "52b90b6ed2ac1e6e7343dfe5d85711660378c6856ae5984b6f8a596ec12d4d68"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.8.0/helios-linux-amd64"
      sha256 "9308ab9ad7f6218decca0d303f4963383738977304132a4bfec513b8c59f533f"
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
