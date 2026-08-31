class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.25.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.25.0/mesa-darwin-arm64"
      sha256 "6a791c774f990cde7e037930dbab5d662aec3944d480f048312fe633fca43199"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.25.0/mesa-darwin-amd64"
      sha256 "165dc765a8b5e8e7d4b150324385ee1e139e84849aff1ecc6b730f8e98283920"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.25.0/mesa-linux-arm64"
      sha256 "5f92c8a7dc3554b4b6114eff1c0c40bdb4dc3ae9b66994464d1760ad99e678df"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.25.0/mesa-linux-amd64"
      sha256 "c0daec0361936507e8c32e0947faaf04e090abe0d8a240a2c16f3a34fe02cdea"
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
