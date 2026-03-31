class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.11.0/helios-darwin-arm64"
      sha256 "ddc67a747ef709636937fadd5339164e672490709718d8edf1644f66d3c91e06"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.11.0/helios-darwin-amd64"
      sha256 "83feddcf186701fad76ab881978ede7089a1a5c6c1b8d2ed00a80827c2d47b3c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.11.0/helios-linux-arm64"
      sha256 "80fe5986835472c5c3540bb4cee9b7eee3fae2b52a233c2b599f6db4437d2e75"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.11.0/helios-linux-amd64"
      sha256 "5d01a7a230dc87b23214509d64f09d53f1144126bb2e4b6979bd93d85dfd5d1f"
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
