class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.1.0/limbo-darwin-arm64"
      sha256 "5337f454972ed5dde7506e1b8818d0c8c3a06662fbc0420d38904611ab7d1aab"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.1.0/limbo-darwin-amd64"
      sha256 "672005854407d860d75e38684a0a3d98c9480acf2b20bb6acfb1ee9f6d229327"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.1.0/limbo-linux-arm64"
      sha256 "56e6e3790433f745de0db3cfbe444cfbdc73ca9001aaf4e871a4b5a6ba68ab76"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.1.0/limbo-linux-amd64"
      sha256 "60c322d0667dea8b9cf731e5fe0977ef15b6b35e3b4d9d1287b3070cc3e0bdba"
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
