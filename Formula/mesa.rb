class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.16.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.16.0/mesa-darwin-arm64"
      sha256 "5a327c20fca864506fccb406a1efac3cf76e0cf6c3dab6e53234781d6ccaec02"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.16.0/mesa-darwin-amd64"
      sha256 "3ad1fe8b896a55cec1198d0ec07f15f468fa9c705b18a12254bffefb8239878d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.16.0/mesa-linux-arm64"
      sha256 "893928ca90171d61338cbeae0a3a540393742708dd3e18e7a81a085033bd5749"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.16.0/mesa-linux-amd64"
      sha256 "4e8e93bcf04f0cfb6a7fd801178764362eac938713fb260e9ccd6f176c48970c"
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
