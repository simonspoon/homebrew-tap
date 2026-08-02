class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.6.0/mesa-darwin-arm64"
      sha256 "e20490883325bbefe2e528efc796cf173f16d58d90389b3bb7fa0743e4999d6d"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.6.0/mesa-darwin-amd64"
      sha256 "0bd1190b26a314268ad475eaf857f8272ce5f3f37ee1668a3c736f8915fec1f8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.6.0/mesa-linux-arm64"
      sha256 "70daeca080d01018ad146edc909901d257434aa3fcdaeccdb392b8b24d9cb4a4"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.6.0/mesa-linux-amd64"
      sha256 "8dc1c79527be91aaea4e4fc0cb06a5a07f1a3a19198ecf7bb4fa2f2b07eb22ab"
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
