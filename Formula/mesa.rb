class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.22.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.22.0/mesa-darwin-arm64"
      sha256 "08ebe2b7fea985ff97b42e2fa155a2967bdeebaeb0164b208ece776d3d21366b"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.22.0/mesa-darwin-amd64"
      sha256 "0940263f4f8dc8a4b9c062b390e61495fd3d4fce663c2bf48c083d34f7c44aac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.22.0/mesa-linux-arm64"
      sha256 "194066c2a7ebf76c7c7143e2876bb347d593e80fa67ba733610a28188c62a2a2"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.22.0/mesa-linux-amd64"
      sha256 "d4c22a6aabdcec0758a3ddb883b00079951b002eadf596231e0aaf9b37255341"
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
