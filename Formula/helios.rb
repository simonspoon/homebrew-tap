class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.15.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.15.0/helios-darwin-arm64"
      sha256 "3e5a49050475ee31fd0654bd6a80355c8e0b97b3c32289fb9a25551deab95460"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.15.0/helios-darwin-amd64"
      sha256 "0e693fea1b5cefd32070e244ec1c8a4eeb2ad9fb57e17b572fbf4edd46ea63f3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.15.0/helios-linux-arm64"
      sha256 "4df10bef63d118eeaccda544b489590948aae6fac5159139748c431ce307ed47"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.15.0/helios-linux-amd64"
      sha256 "33d5522fd7a60b413711dafd3555d9daae9280d9581d6185580116f15865d7a1"
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
