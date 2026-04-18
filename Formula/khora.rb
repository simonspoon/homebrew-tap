class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.3/khora-darwin-arm64"
      sha256 "e270d3a25e65d720f82a1508227eba2a14797e377e773fcb214696f4bae9b1a9"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.3/khora-darwin-amd64"
      sha256 "0f3187e8ad18f318753107f16f688a2fbfff68572eca71483cfe425955ca864b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.3/khora-linux-arm64"
      sha256 "3c95a77c896bda49f4268d4f71b7e2588795534833059929d9c58693386493b1"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.3/khora-linux-amd64"
      sha256 "0dd2c440ea5827e48223fc1c80c720f8284a0971921267e11b51f6ad8c36c282"
    end
  end

  def install
    binary = Dir["khora-*"].first || "khora"
    bin.install binary => "khora"
  end

  test do
    assert_match "Web app QA automation", shell_output("#{bin}/khora --help")
  end
end
