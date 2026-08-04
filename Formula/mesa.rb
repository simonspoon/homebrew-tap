class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.10.0/mesa-darwin-arm64"
      sha256 "3325f3fe2fa7d81326b931cfc7424809e80cb0ebdd5ed12d7962b717751d6ca3"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.10.0/mesa-darwin-amd64"
      sha256 "078a9d1830ad0e3f2424734d9175510be01ed45383c99af3219cecad26ed01e2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.10.0/mesa-linux-arm64"
      sha256 "660f431f26faeb9f492c448ab50f9ad5b77dcce3cb96f247eab8680d1baccc51"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.10.0/mesa-linux-amd64"
      sha256 "ab7dcc11305068d33783526f70f6aacdbf198306c6651a893e314f241dc92fe5"
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
