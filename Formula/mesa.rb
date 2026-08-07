class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.14.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.14.0/mesa-darwin-arm64"
      sha256 "372dc1e0c1cdfe0c753fb4c3f8990940e8d6aa99b55fb887e44912061b88b905"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.14.0/mesa-darwin-amd64"
      sha256 "a983eab29854ffeba94a52f48493ca81a2916989d3edb605ee1b667b6d58ebbd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.14.0/mesa-linux-arm64"
      sha256 "e6b3325f062998d25a1a141a3c400c8504f4ba100ad87449638e159e93ce96c1"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.14.0/mesa-linux-amd64"
      sha256 "052b773cf2e3aee5864ce966664beb3eb722c15c69e65627ef5c1990699e567d"
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
