class Vauban < Formula
  desc "Create, edit, and visualize mermaid diagrams from the CLI with a live dark-mode web viewer"
  homepage "https://github.com/simonspoon/vauban"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/vauban/releases/download/v0.2.0/vauban-darwin-arm64.tar.gz"
      sha256 "7f1bf53a3a966cd2f829ba04135f26db9a5fb36a093cf86ddd3672926b6c98b2"
    else
      url "https://github.com/simonspoon/vauban/releases/download/v0.2.0/vauban-darwin-amd64.tar.gz"
      sha256 "e05db943610436bb066cff90cbf092ff1fdb84333524cd4a58236815851580e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/vauban/releases/download/v0.2.0/vauban-linux-arm64.tar.gz"
      sha256 "7a283ea26319bf1103032b513bef4f209c1c06181329f067a0a37b6244e8217f"
    else
      url "https://github.com/simonspoon/vauban/releases/download/v0.2.0/vauban-linux-amd64.tar.gz"
      sha256 "c47e19c7bd6739c1a729bf171ccb0d49313661a7ce99394811a8443bad2e67ac"
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
