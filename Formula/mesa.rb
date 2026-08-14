class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.20.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.20.0/mesa-darwin-arm64"
      sha256 "6adae3eba833333bc69fe8ea6a8e6d480f0f7afc8713ee0be0023f5c038d11e3"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.20.0/mesa-darwin-amd64"
      sha256 "381894babd2eb62b3f1cd3e2e899f182007876a3fba03c1d7c88dc01e2081951"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.20.0/mesa-linux-arm64"
      sha256 "ae7baa59d222d963ebacaac75be3e028335b7115bf43c029195e4ad1ea61b8b0"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.20.0/mesa-linux-amd64"
      sha256 "9e0278972ee864ade9be1155745caa7ae4c17a8b524ec36baaf24eb3c936a43d"
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
