class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.4.0/helios-darwin-arm64"
      sha256 "66b976bed94f42aa073a38fb61a19943bbacc4193fe149f50d256314a3424eef"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.4.0/helios-darwin-amd64"
      sha256 "23d96d94c3a9149c7ca86c67b4945eb3422780f0724d5697a4f3ece75d5a4b62"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.4.0/helios-linux-arm64"
      sha256 "82a85395b44970d9a2a3bcf4e40abcdc9edde77f79f7567e4270cad7c93cc830"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.4.0/helios-linux-amd64"
      sha256 "bfab0de8c157ece33557594cff0168b3418a2cd13ead9fed4df6571859859eee"
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
