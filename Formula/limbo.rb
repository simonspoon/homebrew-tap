class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.10.0/limbo-darwin-arm64"
      sha256 "acdb4699979c2d5a489fa8cf38a08240aa8491cf61ef3023613c08405f54aefd"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.10.0/limbo-darwin-amd64"
      sha256 "ec4d8a1bab9d044ca53da4cb90c6e86aa6d29c9644356772fc7effe7bc92be2b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.10.0/limbo-linux-arm64"
      sha256 "ab66dda75b0d406cdd245ba3d2bc6ee87f3f32c170b5c251d58bd322b09631fd"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.10.0/limbo-linux-amd64"
      sha256 "0c58ee280deea7df1fa0110992395f72eb6c60bfb2b237ff6d92f9e75c4faf29"
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
