class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.12.0/mesa-darwin-arm64"
      sha256 "c0c9a73598f9095a18f100aa5d9097e35df87df4c9f068da670410d081853aa9"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.12.0/mesa-darwin-amd64"
      sha256 "f8aedfcbdc21a3394c01754fbf013bfdb8ef5f85b63479007411cadb6d2d8e73"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.12.0/mesa-linux-arm64"
      sha256 "1c7a2f24b8245ff56195c96faa78ab95bb57b75fbb8b4253ea933c85c0bc8b15"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.12.0/mesa-linux-amd64"
      sha256 "4e8191cfbf2af9ecf8fadcb142804865e91db574162b2149d53f6a74942da4a9"
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
