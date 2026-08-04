class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.18"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.18/khora-darwin-arm64"
      sha256 "a16bacb665b403141fe1a4d1f3a6914f1ff26e97e8299a24ecfb988ccbda68e2"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.18/khora-darwin-amd64"
      sha256 "3fc1feecda40d1a1dec325df93fe360be12e85cbdc721780a1a34232aabf1eb4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.18/khora-linux-arm64"
      sha256 "468106ddda89358fddb01ac9e136f2880e14e52bcc583ed1035729259e65a4a3"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.18/khora-linux-amd64"
      sha256 "ef6cc0b84fc85136dface70f46a2a785e429d5ea36581bd485cf09f675f148d9"
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
