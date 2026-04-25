class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.2/simaris-darwin-arm64"
      sha256 "008567646c6fbcbcb8d9c9a3bd9c235593519da3ee0d62f5598948f0146b72a3"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.2/simaris-darwin-amd64"
      sha256 "7a4d0b894efac71721c1678388a596cca35ffe2da2d4ae937095b7f5a6d633e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.2/simaris-linux-arm64"
      sha256 "e3f0923b4dccad53ae0831fb5baa3d287e514ad4a8c30d30658c84387e29bac0"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.2/simaris-linux-amd64"
      sha256 "8d4699cb6039e417e89fb6db8ef6cac0d2d49f86e10c2fd7007fe4c004266ac7"
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
