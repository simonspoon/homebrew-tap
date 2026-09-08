class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.26.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.26.0/mesa-darwin-arm64"
      sha256 "8e5bde8cc242e8bfdc93cb0015c5a5a40a9cc08c609e08edc8ae260dc4ba770d"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.26.0/mesa-darwin-amd64"
      sha256 "3a7d84719c30f027938f3f0a02f2d567ca0a74eb921d07868f97f8566d221768"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.26.0/mesa-linux-arm64"
      sha256 "3bf59d879cf64c5fd2b777aba07828d135a1280180172c5385fb5861f44c6dc1"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.26.0/mesa-linux-amd64"
      sha256 "97ebdedd241d1ce6044f0a32c962008783cfcdd363a8f5f016b3c5c32d378447"
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
