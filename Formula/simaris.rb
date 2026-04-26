class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.3.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.8/simaris-darwin-arm64"
      sha256 "d0f2980400927104fcc67e3e3ac0fc48e62e70f4b6a322ef0d5f1fd42cc50476"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.8/simaris-darwin-amd64"
      sha256 "77a575a36ff94e87b11dc68085f21a5833b0882e1422bcb85fca2d2bed55cd5c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.8/simaris-linux-arm64"
      sha256 "0b46d98c71f7228780667b7f6480943d2431eaf157310d6179ea0223a63d6ffe"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.8/simaris-linux-amd64"
      sha256 "68610dba07ca8bcfc006d63fdad8f2b4f4cc443cc02d044f5345a77570d2858f"
    end
  end

  def install
    binary = Dir["simaris-*"].first || "simaris"
    bin.install binary => "simaris"
  end

  test do
    assert_match "simaris", shell_output("#{bin}/simaris --help")
  end
end
