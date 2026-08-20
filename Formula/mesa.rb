class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.23.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.23.0/mesa-darwin-arm64"
      sha256 "a780eaa65a00a4efb718b7ffca97484484e62cfb687104c65ca20c7f2d77eda7"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.23.0/mesa-darwin-amd64"
      sha256 "a49239850eed739bfe96e2457ab4b9cdf6c544d0bf1f7920b8e428117992a01f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.23.0/mesa-linux-arm64"
      sha256 "6adf9088ab151c37c84b2741afa69687d3a067bfb3069adbf978be52eb571924"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.23.0/mesa-linux-amd64"
      sha256 "8071223d398a4a4eff5006f31214e1df23543ca14201777608d077ed9da947b3"
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
