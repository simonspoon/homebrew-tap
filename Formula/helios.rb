class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.46.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.46.0/helios-darwin-arm64"
      sha256 "683b24a10990d2587ddfc5fa6e2e368b0fcbebd6cbdfeb7f7f6fc7e150ed9004"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.46.0/helios-darwin-amd64"
      sha256 "1f60355caac9ebee9142f9eb2c4f9f79c50ef58d65bbf085d9b7685237500ba5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.46.0/helios-linux-arm64"
      sha256 "9665232af6c97f78c8e6647293d6648e83fe7d31d523f35d6c65ce9e04a34928"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.46.0/helios-linux-amd64"
      sha256 "73ebd36a0753552c30fd93f10aa59380b3746c692371f45e9b44741cce7e5630"
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
