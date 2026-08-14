class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.31.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.31.0/helios-darwin-arm64"
      sha256 "efee3572922c254076e932ee0079f09866bba177f752cdcba6b69df5b60d3d6e"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.31.0/helios-darwin-amd64"
      sha256 "e3c248dcf5d5a3c991f5f4603b44695068373d0765d0492070d337b9ca45c9cc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.31.0/helios-linux-arm64"
      sha256 "fc5515b6e27c4e689d6e9877fe4ab9742242e527f25ad37f7aff1360556b9b3f"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.31.0/helios-linux-amd64"
      sha256 "9b3d2d2daf28595cad716bce10d9b36c5891c105551cc6045349b7efc6729466"
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
