class WispCli < Formula
  desc "CLI companion for Wisp, a desktop UI design tool for agents"
  homepage "https://github.com/simonspoon/wisp"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/wisp/releases/download/v0.3.0/wisp-cli-darwin-arm64"
      sha256 "8e0ccc23513cb6878fd86a451bb188d67bbf2c4499803867dea0b33edf695ef8"
    else
      url "https://github.com/simonspoon/wisp/releases/download/v0.3.0/wisp-cli-darwin-amd64"
      sha256 "cc68527bf2732066110b7b17cd74621e60e4c9cdd819676f0b70da65a4590e22"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/wisp/releases/download/v0.3.0/wisp-cli-linux-arm64"
      sha256 "bbd6f3f97a3c32e9c15db93cff3041a6aae9a647e1397bdc33343804fb316fff"
    else
      url "https://github.com/simonspoon/wisp/releases/download/v0.3.0/wisp-cli-linux-amd64"
      sha256 "68cec3b3321664839e13fa3d9a371afe22556928d63ae4b3bbe90026dc115d51"
    end
  end

  def install
    binary = Dir["wisp-cli-*"].first || "wisp-cli"
    bin.install binary => "wisp-cli"
  end

  test do
    assert_match "wisp", shell_output("#{bin}/wisp-cli --help")
  end
end
