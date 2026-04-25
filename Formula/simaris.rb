class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.3.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.6/simaris-darwin-arm64"
      sha256 "537f669cfc9ea0953b13200ca6de5c4dea4be08dab727f5b2775c2898cfbf952"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.6/simaris-darwin-amd64"
      sha256 "0d1b58db77b3616ae860eae757935ccd281edca035f4740fcf345d895ae8ae7d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.6/simaris-linux-arm64"
      sha256 "40cd2bae806773433e400235dd7a99dc47e6b43f4b2dd3fb37eab94d47fa55e4"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.6/simaris-linux-amd64"
      sha256 "2e1ef44448ab4ee946145d581e32dfbd938176e108e57c191279b0e8db0f2b41"
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
