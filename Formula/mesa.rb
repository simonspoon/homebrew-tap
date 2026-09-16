class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.1.0/mesa-darwin-arm64"
      sha256 "b3ed435134ea36eab70a9f3eb5f6559199323c8ca6d38cb83d95102d35723a4d"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.1.0/mesa-darwin-amd64"
      sha256 "11cafa35cbb8a4be2658b9fe4a1d7d4797ef4b8be83b5552e69a350fcb0c2416"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.1.0/mesa-linux-arm64"
      sha256 "9359100a4665e4447d135685539f8689d59a1e510e7dc7f9b65eba1667b24590"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.1.0/mesa-linux-amd64"
      sha256 "46a7fbc7827508ae7b563c804a1439d151d58e842c511eec0634730de4e31aad"
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
