class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.11.0/mesa-darwin-arm64"
      sha256 "5c3d53292bd40c9f6eb1cd709f5f322b363661f4f922f614f2e607afbb8aa62b"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.11.0/mesa-darwin-amd64"
      sha256 "1266ee6bf9409cba5d07ba25a7733ce9f20354c03ab95ea5dc9ff1cee25d40a3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.11.0/mesa-linux-arm64"
      sha256 "d30a9095b9ab8aff199b32e506b650748934b9df6f37a0e7ef908f65686c68ab"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.11.0/mesa-linux-amd64"
      sha256 "e460b84aa64446ab12edf81158361026eabca75b7203b26f54948a43a3e7c218"
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
