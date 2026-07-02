class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.17.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.17.0/helios-darwin-arm64"
      sha256 "0b2797a8eba4d5627fbefa80f0bea824ab87ad42083a31f28282c814e5c5841c"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.17.0/helios-darwin-amd64"
      sha256 "23daa8131ec1e39fd2bbd3e035db4a82b90ac204cb7129a3f22249602239a66d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.17.0/helios-linux-arm64"
      sha256 "497eea6f3c02e1e0d3a65a112fdba60ffcfa89c32e519c6d883a8aac8ea9efa8"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.17.0/helios-linux-amd64"
      sha256 "b2af9ff9cd619707ebbb912aed6a2a7d36420aaa84d91b3240d3aadf3efcc79c"
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
