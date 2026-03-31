class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.10.0/helios-darwin-arm64"
      sha256 "738ff44a4f38c9a22ecab9caf1d13af23eb789449b6b23f2acc5595355901de4"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.10.0/helios-darwin-amd64"
      sha256 "95845406ce26b12f70e994ee196375526e283c0f45907fe72b5c2802037fe99f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.10.0/helios-linux-arm64"
      sha256 "d24625f5adbfb5852f8cc02cea2fc46bbb5642b600817f5effd0adc92c971af6"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.10.0/helios-linux-amd64"
      sha256 "3fdbe99d001918948a9c5ca53680dc89d714afae8bd0fc916ac14671c3124ebb"
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
