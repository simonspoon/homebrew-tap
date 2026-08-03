class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.7.0/mesa-darwin-arm64"
      sha256 "b36d9c459becaabb307f0c9969a0b4678bfe4c670a886711a6f428861f5e3b81"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.7.0/mesa-darwin-amd64"
      sha256 "9667e63e0dd94cf60a0aa87e3080222a12817ed3fe223f5a9a7d51f2038d493e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.7.0/mesa-linux-arm64"
      sha256 "10af40354b2a4afe690648152e79e9b070581fa65e73d85e5e8f0cf4d27e358a"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.7.0/mesa-linux-amd64"
      sha256 "485ab32f9381c2bc2098f95d77c090f7fea2f7d9ae5804fda4c5e4f1bc50c74f"
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
