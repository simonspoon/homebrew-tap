class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.16"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.16/khora-darwin-arm64"
      sha256 "06fe5d922485cc0b9febfb033dc4248b6cfa27dc617c0ef2bf0f54ce8143ea4a"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.16/khora-darwin-amd64"
      sha256 "20537c8903e3f3167e153aacb1cd53a683c88f6db46274f794455b8cbd9f8da2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.16/khora-linux-arm64"
      sha256 "4f71bf860590c46cc8b60206cc2fedb535b789dac4193f09ae69e06f5a61523b"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.16/khora-linux-amd64"
      sha256 "56d83aed2645b4848e50d7f37f4f27d8d90984b7adfdfc4dcfb37fee4cb53caa"
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
