class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.9/khora-darwin-arm64"
      sha256 "3613eb8f1e1ea6ff53b34458290c6aa58c855e81d84e6cb91645d8dcddcfc0b3"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.9/khora-darwin-amd64"
      sha256 "ffd8b94b3a4d7432e6581d8380bbd53aaf4feb233c8f74fb412d54a1bbfe5abe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.9/khora-linux-arm64"
      sha256 "1549b165fe7f54290e32bd0492f0351aef098214fc9d1be0661cadd34fccc603"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.9/khora-linux-amd64"
      sha256 "4947b61c0ffa90e9fec74abcef43ca8142791be9a1ff79869be7f938934dbd19"
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
