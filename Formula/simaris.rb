class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.3.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.9/simaris-darwin-arm64"
      sha256 "901f09ba115ad72221d500a790b024f7614f4651ecca2c894f9ac387da42b99b"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.9/simaris-darwin-amd64"
      sha256 "c2335991df935c1eb146bd419bf19bdbd900ab660646cd348a645d7f1c072b31"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.9/simaris-linux-arm64"
      sha256 "7b0face954d2760ddacb6696dd487258fbcd3f95b88bce2a2080d8ca1095ee6d"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.9/simaris-linux-amd64"
      sha256 "9c70c8b01ccbb2743e3acdf4aaa2e5138d7cbb04f0b4e8821ced939e21823cba"
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
