class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.15.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.15.0/mesa-darwin-arm64"
      sha256 "85e464f87553b381c67e5ba2817982e066ebacb786bbee7a5baf1ea5ecb3ce52"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.15.0/mesa-darwin-amd64"
      sha256 "a90899733f88dae450ff67d4a2704439152f469350743800f8b9ba955db25c92"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.15.0/mesa-linux-arm64"
      sha256 "79ff577d3b4e9f25ba306954509801d0e6b2bb2d73eb5655b8afd5b89c5f76dd"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.15.0/mesa-linux-amd64"
      sha256 "9e584468fd5ad7981b32b992f877127df7ccfb4d66d41850c5b8fda7b615a7e2"
    end
  end

  def install
    binary = Dir["mesa-*"].first || "mesa"
    bin.install binary => "mesa"
  end

  test do
    assert_match "mesa", shell_output("#{bin}/mesa --help")
  end
end
