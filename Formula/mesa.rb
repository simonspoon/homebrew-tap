class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.28.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.28.0/mesa-darwin-arm64"
      sha256 "0f03788fb084fa20e127e58476cf0658bd2d8b63fffd4fd96e754aaccc6744b2"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.28.0/mesa-darwin-amd64"
      sha256 "f688ca05e3d08cb06c6542a2a1cc6acbd20d7ed09a77cd6940a317988f91a0e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.28.0/mesa-linux-arm64"
      sha256 "f3905c48dda3bfd45262ff533e1971c071f9226e78c2c774a5d2107b3ccf2293"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.28.0/mesa-linux-amd64"
      sha256 "40dae2438e4ef3b30c3e6848b336e82331b5ee36343f3bd79772e36c854948ec"
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
