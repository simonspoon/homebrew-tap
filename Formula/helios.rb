class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.18.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.18.0/helios-darwin-arm64"
      sha256 "8792208724be4fb53135f4555512a997be14e5483a197538677a4625a3dab32a"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.18.0/helios-darwin-amd64"
      sha256 "581acd6f62637dda90efec00e590dc7e521fe0c62623069265e3936808785dfb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.18.0/helios-linux-arm64"
      sha256 "4c0dd98ddfbafa1fae13bd155bf8f2d7b6032a3a8bf0101a1e9fdc89817d731a"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.18.0/helios-linux-amd64"
      sha256 "bbc88ada29a42d7412e9b962b9ed4a146b4e638c1265e89a9e2c5ed4e4a77c6d"
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
