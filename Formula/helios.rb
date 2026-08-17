class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.33.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.33.0/helios-darwin-arm64"
      sha256 "9562a7e60d383e5fc77cb7f82b6d67d7a6264b5fe280983662087adf5f01497d"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.33.0/helios-darwin-amd64"
      sha256 "5311ee503183483a07259f5aadb162ae2f5b4c1cc2af477027d4c59722dc3202"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.33.0/helios-linux-arm64"
      sha256 "ea75d2089c86c10b65d22f09242ce795cec3f2397f9458285d631012a762fbd0"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.33.0/helios-linux-amd64"
      sha256 "2edc3aa58ea9e41e8fa3fb3d89fc1e9c03d036b1b43067f5fb2f78bf808f8954"
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
