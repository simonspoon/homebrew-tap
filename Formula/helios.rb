class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.6.0/helios-darwin-arm64"
      sha256 "e2ff9fb76c2255dba3d13b3967905a8e3774e3bcaae4afd1432e5d35fe75f698"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.6.0/helios-darwin-amd64"
      sha256 "0d1438f3023d12bbc0a70268366102708e105a2ec9e1b7df39f81c7603c43031"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.6.0/helios-linux-arm64"
      sha256 "87f37550848d58c71ff3bfd7f079564468216e414c4ea4aff82f2147c7bb3fcc"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.6.0/helios-linux-amd64"
      sha256 "ac36572f3bbfec5326789c947932a809d7a42e356146e387d96113bb17092df9"
    end
  end

  def install
    binary = Dir["helios-*"].first || "helios"
    bin.install binary => "helios"
  end

  test do
    assert_match "helios", shell_output("#{bin}/helios --help")
  end
end
