class Nyx < Formula
  desc "Index and search Claude Code conversation history"
  homepage "https://github.com/simonspoon/nyx"
  version "0.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.4/nyx-darwin-arm64"
      sha256 "03337211269b975b8b727837cff1abccc741560d9bf3228749ee1ba6481d188f"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.4/nyx-darwin-amd64"
      sha256 "8293703e0b250daa4c202bdfb1a5a4871db96c5373bc396651e51153ec6aac7a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.4/nyx-linux-arm64"
      sha256 "556757351448d8b37589ef5a680623a107072cf5c0b871569afd1425ab148ae7"
    else
      url "https://github.com/simonspoon/nyx/releases/download/v0.2.4/nyx-linux-amd64"
      sha256 "a672b9aeb1ffa33d709beb361d0d4712c9c00f2b66eda0bb039a560cd2cfe1fa"
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
