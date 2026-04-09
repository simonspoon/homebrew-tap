class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.0/khora-darwin-arm64"
      sha256 "853011cadb278ecdd5e0d22c0299ba49f2de35525dd0aa062b141c6286e33e53"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.0/khora-darwin-amd64"
      sha256 "9fa6f53873c79b02fbaaa330acfc0efca8fca941e874c1b6514202d765387a11"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.0/khora-linux-arm64"
      sha256 "d5ce27e87e70bb1c5cb3b124186d3ec09eef373480a4d4468cc1f48265a82056"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.0/khora-linux-amd64"
      sha256 "7053576d36fae8c174ae992d6aab13fb55792de030e1930a9779248c9307318c"
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
