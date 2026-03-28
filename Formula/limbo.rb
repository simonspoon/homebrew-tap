class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.2.0/limbo-darwin-arm64"
      sha256 "338c97e2dfb667041e4c3699546cdef6473ea0fa5d00e870b583db81d105daca"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.2.0/limbo-darwin-amd64"
      sha256 "b5e828288dc4fe1a655ac848a644ad5bba9813944cd74b3fb61edea9d789471b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.2.0/limbo-linux-arm64"
      sha256 "519d6c9fae3938080374b95528101d698545e982b3710b9137fbe0e74eba6770"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.2.0/limbo-linux-amd64"
      sha256 "8628549daf6baed495cbfde6b51d1466c44183c086bb43f33852cd87e8d6d0f1"
    end
  end

  def install
    binary = Dir["limbo-*"].first || "limbo"
    bin.install binary => "limbo"
  end

  test do
    assert_match "limbo", shell_output("#{bin}/limbo --help")
  end
end
