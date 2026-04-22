class Vauban < Formula
  desc "Create, edit, and visualize mermaid diagrams from the CLI with a live dark-mode web viewer"
  homepage "https://github.com/simonspoon/vauban"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/vauban/releases/download/v0.1.0/vauban-darwin-arm64.tar.gz"
      sha256 "600130c449557912b9571ca0bc98c746c51939d6035e97c7357127a4705da407"
    else
      url "https://github.com/simonspoon/vauban/releases/download/v0.1.0/vauban-darwin-amd64.tar.gz"
      sha256 "4a43307be98ea1b94c7104f2669fec397d4cee7f3d340757e1aabfba77ff5600"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/vauban/releases/download/v0.1.0/vauban-linux-arm64.tar.gz"
      sha256 "5ab34de6f4bccdaeaaed5b1ada62b950e25c358a13c17e33bfe90aaa05fedd66"
    else
      url "https://github.com/simonspoon/vauban/releases/download/v0.1.0/vauban-linux-amd64.tar.gz"
      sha256 "cb504acc7090397c9f89aa8dda3dfe90cbedd7755c68cfefde467fca7f850b1b"
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
