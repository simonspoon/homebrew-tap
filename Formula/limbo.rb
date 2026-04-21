class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.7.0/limbo-darwin-arm64"
      sha256 "815f5b9adad0cffdffc4b1933615a4e1333760641fbd0586609c0458d9e08ed5"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.7.0/limbo-darwin-amd64"
      sha256 "2bafe361e62b9b45e4cd5fe7dd340c25c0b282075abbc27185fcacfb47b856e9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.7.0/limbo-linux-arm64"
      sha256 "2d0cabb4cfbc382233a4db17823a57b6a0808612b11f51f1a65d01e144d6449e"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.7.0/limbo-linux-amd64"
      sha256 "afbbdb83905cc2c7f69846eae975242e964045c67cb2a4fa77bc2ee37f42d0cf"
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
