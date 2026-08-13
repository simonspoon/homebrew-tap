class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.18.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.18.0/mesa-darwin-arm64"
      sha256 "38fdae482a24a1558cd88ddbf261247a3255baed188ef78b36353ba5d79557c6"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.18.0/mesa-darwin-amd64"
      sha256 "0b81139bf3e818d800948b7a8f10a65c1e929d42983daa52f320eeefcad033c7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.18.0/mesa-linux-arm64"
      sha256 "8bed177b11c421c228b13eb5c212059747576cf27e09c3b74d3ddc3081dace92"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.18.0/mesa-linux-amd64"
      sha256 "286d796a067759a513f4dd70a6ba194294ef5f930007ceda33151fa4cb9318e2"
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
