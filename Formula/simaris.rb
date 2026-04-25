class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.3.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.5/simaris-darwin-arm64"
      sha256 "3b27a64e1e2b65ad79bffff35105509b107052f33d76caaf75c658c53dca627f"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.5/simaris-darwin-amd64"
      sha256 "378a198ce6f846c261508ebbcd297e90318cc4f6ba6d55c09e67cccfeadafd65"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.5/simaris-linux-arm64"
      sha256 "a3253411299d1e573f3a8fd95f85b81847813dc52dcb18900c75d73eb25b08b6"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.5/simaris-linux-amd64"
      sha256 "5408bf7cc70c63167fcaf98c6729aa856d25bb4780d32e908048b7103d8abff2"
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
