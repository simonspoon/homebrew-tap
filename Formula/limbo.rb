class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.4.0/limbo-darwin-arm64"
      sha256 "9997a452aef4f1ce1138864997314b92a622523ceb7db71404970e46efea96b8"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.4.0/limbo-darwin-amd64"
      sha256 "03040ca568c2cc5133c17d67c1b55075c5b8b2dc23dbf838799cb9c662e37df2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.4.0/limbo-linux-arm64"
      sha256 "8beb1f7a12ddd660c0a5d9d5ff7795f2179e3fd4d953113fbc15d33323f867b9"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.4.0/limbo-linux-amd64"
      sha256 "8c5aa68acf1a79d23a73aff09bff848e80fffb2e265297d5ae18bbbf4f4e0977"
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
