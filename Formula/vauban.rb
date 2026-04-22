class Vauban < Formula
  desc "Create, edit, and visualize mermaid diagrams from the CLI with a live dark-mode web viewer"
  homepage "https://github.com/simonspoon/vauban"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/vauban/releases/download/v0.1.0/vauban-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/simonspoon/vauban/releases/download/v0.1.0/vauban-darwin-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/vauban/releases/download/v0.1.0/vauban-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/simonspoon/vauban/releases/download/v0.1.0/vauban-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "vauban"
    bin.install "vauban-server"
  end

  test do
    assert_match "vauban", shell_output("#{bin}/vauban --help")
    assert_match "vauban-server", shell_output("#{bin}/vauban-server --help")
  end
end
