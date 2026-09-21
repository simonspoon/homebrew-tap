class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "1.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.5.0/mesa-darwin-arm64"
      sha256 "4063a7b473d4e8ca0cff9e0335aa7cd2312c6d909e6d52ff8f8890f453050142"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.5.0/mesa-darwin-amd64"
      sha256 "a49903f2226c0c254723b6e3d374cceff0bf55ba8623d24aa20a261787fa94c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.5.0/mesa-linux-arm64"
      sha256 "a493b5c686ad65a68d9c3129ca7dc40f109d72afc422d75176afa7beb5a7ef53"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.5.0/mesa-linux-amd64"
      sha256 "bc8b68c44e23e4d8e166fccdd951986bb265772d7c9cbb2d97d19474caab2980"
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
