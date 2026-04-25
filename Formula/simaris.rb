class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.3.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.4/simaris-darwin-arm64"
      sha256 "e4784c1be10c60261881b095f4edadf11af2896667555d2044dacd75f3dab5ce"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.4/simaris-darwin-amd64"
      sha256 "0c7be22da56e64166b187d3f7dc644a64db5d23637789822a905834e33403fe5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.4/simaris-linux-arm64"
      sha256 "92de5dd4a3de6b8dc68c918a27f96978f2d7c8c2147cef8285b9669bca868d10"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.4/simaris-linux-amd64"
      sha256 "876e58ca2c0ce05ff91bf6bac2313cf7071ec027141b9ed7cb94fe2095f82711"
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
