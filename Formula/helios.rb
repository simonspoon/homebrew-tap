class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.16.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.16.0/helios-darwin-arm64"
      sha256 "4c1b61c3f9f401185c792d0666abcbc9c3b03e0253304fb7c96b9eabb6c938dc"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.16.0/helios-darwin-amd64"
      sha256 "db03aaaa52afceb197cb3a1b7cad9a3655a2a240aab67962f67c8f314e20251d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.16.0/helios-linux-arm64"
      sha256 "f2552e56d1a13e9756899aa20b9306eda62dbfa0fbcdb3219ecbcdea130136fd"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.16.0/helios-linux-amd64"
      sha256 "924f5983fcd9fa2d708513a96a0d0942ef3f85850e3e183b38ab8c91fb9645d0"
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
