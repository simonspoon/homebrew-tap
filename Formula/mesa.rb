class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "1.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.7.0/mesa-darwin-arm64"
      sha256 "ed842735440c21b5fe06fdb58289b3fe0f06d207afa9aca5aebf8c82593ad800"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.7.0/mesa-darwin-amd64"
      sha256 "22fc963fd39ccac43197857604d6b720a1a6235440a0453c9ff3bc9346b8182f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.7.0/mesa-linux-arm64"
      sha256 "d6dcf9603458b0846cb4e4561d1dfddedaf78d8a4846b7ac3e23babbc1381f1e"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.7.0/mesa-linux-amd64"
      sha256 "6a3dfd5d81fb1a123113a854894bf0dc41a4dca2614a9fbc554876fff72c2ec9"
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
