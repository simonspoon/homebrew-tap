class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.47.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.47.0/helios-darwin-arm64"
      sha256 "ff975d865c1c4d883834c771ea55829477dce92bf462861d19935dce34ba5172"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.47.0/helios-darwin-amd64"
      sha256 "b10ccc30693ed7ed72e5d86ccafdd9a6685e1892710a1a96fb3dc161e761f39b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.47.0/helios-linux-arm64"
      sha256 "4d155e9e32d6e629a1703f67ca0205a750441c1e00997e78ef1e010aab197e17"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.47.0/helios-linux-amd64"
      sha256 "5f6c4ffb25c82ac9d9a44492104a5133e16f0bcd868a8926a95d525d911d416b"
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
