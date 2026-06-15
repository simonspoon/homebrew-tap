class Nyx < Formula
  desc "Index and search Claude Code conversation history"
  homepage "https://github.com/simonspoon/nyx"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.3.0/nyx-darwin-arm64"
      sha256 "891a757009ab558d03ac7337aa6bb5c65ea3582362015663c3604b232006ae42"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.3.0/nyx-darwin-amd64"
      sha256 "c14c2b1001226c5ab98f4fc48da41236cdf5f98e7924b9e8e7bb6650073b8faa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.3.0/nyx-linux-arm64"
      sha256 "3e291fc48e3fdd9d561c557c63d65cb24baef46564ecef374315f600953fd169"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.3.0/nyx-linux-amd64"
      sha256 "e544207065b57c05493ea02ee061d80698c3a9c88d25ed2e3b2c2bd8694460ae"
    end
  end

  def install
    binary = Dir["nyx-*"].first || "nyx"
    bin.install binary => "nyx"
  end

  test do
    assert_match "nyx", shell_output("#{bin}/nyx --help")
  end
end
