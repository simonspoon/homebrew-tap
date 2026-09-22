class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "1.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.6.0/mesa-darwin-arm64"
      sha256 "e804214ae28ffecf1eead7a5b63cc18867bd6b710db6012a26545419bb4aec65"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.6.0/mesa-darwin-amd64"
      sha256 "b425e8880d377577d97935ca6cda35dfbab14b3ad2dc3f4e6ec36958c27db769"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.6.0/mesa-linux-arm64"
      sha256 "b0a9a4a72d6aa00631d7249033cb20069703e50563cb6962d612f0c051d391f4"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.6.0/mesa-linux-amd64"
      sha256 "e60030e59c9237cd49e07aae795e49686292ac614811ed5ebdc2b6b34f5f0f68"
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
