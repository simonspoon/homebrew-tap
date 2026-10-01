class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "1.15.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.15.0/naru-darwin-arm64"
      sha256 "771c0cb2d25de1b9ccc2fa0753a9ae9680878a643881423475ac2f2c07215d3a"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.15.0/naru-darwin-amd64"
      sha256 "240e393ccbe9d8005bd002d5a193bcadfa79caa6461458f1ba348a79e15b154c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.15.0/naru-linux-arm64"
      sha256 "b1af0c081dcdb7484efa0f0d540c397807ce1e2a1b3ab3cbcb096b80dd23ed45"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.15.0/naru-linux-amd64"
      sha256 "f911ea5bb1457ae4f02b225736bee798c2f45f776c665d3bc82fd8da6c70fa29"
    end
  end

  def install
    binary = Dir["naru-*"].first || "naru"
    bin.install binary => "naru"
  end

  test do
    assert_match "naru", shell_output("#{bin}/naru --help")
  end
end
