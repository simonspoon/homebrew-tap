class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.5/khora-darwin-arm64"
      sha256 "f8c42a913ae6fb6b5a16c0bb07247c6bf466dec352ecefaa562122e6db71f3f2"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.5/khora-darwin-amd64"
      sha256 "ef678b55f9f3826b71d6f054ae11ef9df007632844545e09274dcb97ec5cca33"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.5/khora-linux-arm64"
      sha256 "c94fcb918d223d54beb9dddf21851c7fc29237f38cc2dd6c96681dd9da49f850"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.5/khora-linux-amd64"
      sha256 "09939b60f76ebc7bfda5c538ce5057275a685bfe06c9592b0eeebff4b9630fab"
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
