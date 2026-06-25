class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.6/khora-darwin-arm64"
      sha256 "817bbd4909954bbd59447697f1197b782985b4c921251d9b01f7ec154962b0d6"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.6/khora-darwin-amd64"
      sha256 "ec932c39d2c9935163a4dc75085e1e1f7db170fa7d5d1b57ee1725f59c438ead"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.6/khora-linux-arm64"
      sha256 "ab7d902c1cf9ecaee15d23ccd4b469c3f10528abef1c088b50b07fe5cf0fdad0"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.6/khora-linux-amd64"
      sha256 "ed2c0d9295925845b64d8d07499d5610157a8f28ad18c46213e479ef0f2d42f0"
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
