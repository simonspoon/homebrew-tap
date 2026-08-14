class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.19.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.19.0/mesa-darwin-arm64"
      sha256 "def00f5d320c1770c237dd3183760514856f0d8a22c52883c739848d20e471f1"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.19.0/mesa-darwin-amd64"
      sha256 "77a57c97cd0113bcd455f42172a05c8fd5a505c01a586169de38833dc94363e4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.19.0/mesa-linux-arm64"
      sha256 "693fd0066a8b235d2ddc4e3cf2d01ecfe264a43d0090d906b783d01a2f2da53d"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.19.0/mesa-linux-amd64"
      sha256 "16cb9875b6d7e1aaa3aad614d914ac4be15fe404bbd370a63a680484e5c3f9b7"
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
