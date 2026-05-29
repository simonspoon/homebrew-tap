class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.9.0/limbo-darwin-arm64"
      sha256 "8092f20b780771040b6486bedf09483ebbb13fa60ffa853a3515c3d7e17f0e1c"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.9.0/limbo-darwin-amd64"
      sha256 "c4abc16a55c607e65d1c9a2f4b9a7fe55cbe2647b1e4eca6f0569a8d3301996f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.9.0/limbo-linux-arm64"
      sha256 "81829b84270bfaa43ab68db6c9346f7648f1ae40ea24c1e3788e6c8a9670662a"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.9.0/limbo-linux-amd64"
      sha256 "6f1feafcd8cda498ceccc2a22540db2e37a056130f3e3af3e13d7f569dcbcdec"
    end
  end

  def install
    binary = Dir["limbo-*"].first || "limbo"
    bin.install binary => "limbo"
  end

  test do
    assert_match "limbo", shell_output("#{bin}/limbo --help")
  end
end
