class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.17"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.17/khora-darwin-arm64"
      sha256 "8426f07523995f2440a68d67ad123c4240c588830b9f0f7c62f06f0da5cac691"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.17/khora-darwin-amd64"
      sha256 "71ce2b7f592b5f530184c61dd83d782f7235088947bd573ffc6a366fdb51b0e4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.17/khora-linux-arm64"
      sha256 "0dbf9f06e4bc0db241a758e9424c8b2eb891a48b7613a71c49eb18cc89a7eaa7"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.17/khora-linux-amd64"
      sha256 "6bbef4fb49be622996f4c1bcb392a86b2775c6559736be4257aba65ee486e2ff"
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
