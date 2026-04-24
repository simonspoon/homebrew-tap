class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.1/simaris-darwin-arm64"
      sha256 "1ef65b42dfb0b2033fe7ee8a39e7b4d2192b9139735674a074b1dc8f381bf601"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.1/simaris-darwin-amd64"
      sha256 "4c5b7cf85bb0e03007fd20cf3a4b7279eca3e047c4345d33221ae0da44f9d9ac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.1/simaris-linux-arm64"
      sha256 "1a7842526d5f24ed59cce50c889eaa3b87a103c83b5e15418e6c1e0409f0e88c"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.1/simaris-linux-amd64"
      sha256 "730906b998b05b45f9c5673485191d49765550e8433e7e8362add5e9cdfe4001"
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
