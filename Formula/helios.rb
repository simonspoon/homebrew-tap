class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.44.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.44.0/helios-darwin-arm64"
      sha256 "8856cdfefd8954f700cd9c2e48666b698108fe6253deb70c354769cfbafb65dd"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.44.0/helios-darwin-amd64"
      sha256 "09f35b7de1334c33eb3b4bb350a111702f9a56c732cd3b6ef25fdda283ed2a3c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.44.0/helios-linux-arm64"
      sha256 "938ed75acb8614727dd8404478895a38faf7d9b624ed3353573739f34dac93ae"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.44.0/helios-linux-amd64"
      sha256 "8df257e9fe796d5003bfd11d3964d5cfddfb5899f8402d086b37b505a08fd84a"
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
