class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.1.0/helios-darwin-arm64"
      sha256 "a17e555e3934b86cc5fca882724cca1dbb89f9fa41a7f1c6cbfde51cf556e126"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.1.0/helios-darwin-amd64"
      sha256 "dea562640b5ebe15b35fbe6c4e132a3b6a0f37f1ae88461e4121eaf51de23be2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.1.0/helios-linux-arm64"
      sha256 "a1f9f2434d995a4e2e473c9ce7f3651dc66ec11cdf0334d3fee2ba7dcd1fd2c7"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.1.0/helios-linux-amd64"
      sha256 "89be510e4cb1b6824f0602796d6400c9efc0e9282318f01fab7d115a5953e79e"
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
