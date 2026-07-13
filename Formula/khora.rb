class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.12"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.12/khora-darwin-arm64"
      sha256 "0f4cf76202618da9e0d223692ae258c3321e022f4ec5f0ce6b49d6bfe3c68f33"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.12/khora-darwin-amd64"
      sha256 "1b04ff35dfbbfe98c5abb4df0b5753ae138e317fb0b0789a55d49803e5e983a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.12/khora-linux-arm64"
      sha256 "989a86e347ee8d0066f6bc5cf74cac3444c3aecb6bdfcefbfb60b640c8c2be9a"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.12/khora-linux-amd64"
      sha256 "9582cb3ed10ce8f6e80447b6e483ba08953be7b6cc65b70725d0f49bb7c07b65"
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
