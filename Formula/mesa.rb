class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.24.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.24.0/mesa-darwin-arm64"
      sha256 "ac31b25537b79cc56c87f6f0f80618e15d063aa7cb34e76c03d3db597b3a62a8"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.24.0/mesa-darwin-amd64"
      sha256 "b429287cae4b1076b0cb54c41e58281c2121f0f2c9e5b99b2a892df1aa9f2ca0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.24.0/mesa-linux-arm64"
      sha256 "b7584c4d5fb624d62ad9390ddb4c52beb8f48fa7dc1c4e0f16886d9a00bc10b5"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.24.0/mesa-linux-amd64"
      sha256 "7cb335250136d5f20433186a442329c6714d1f6ed950cf5532e93723f550786c"
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
