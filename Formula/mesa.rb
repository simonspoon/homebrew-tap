class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.8.0/mesa-darwin-arm64"
      sha256 "91d50bb01161d18ca195752bbb1920bca5ddee17c8f4e18dfbaf8a58c85d7204"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.8.0/mesa-darwin-amd64"
      sha256 "6905748f700bb8855c830cc10fe984d57d4f07c18874c6542d89109e297d3782"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.8.0/mesa-linux-arm64"
      sha256 "c7ca7d289bcc242e16035f3d64d05e8887a449b52d507bf24baece579ee0f02d"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.8.0/mesa-linux-amd64"
      sha256 "cf18d74eedcb9a49ade412b0baffa76f49b876d5cf54f69a0bc00fa72a22d06d"
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
