class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.14"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.14/khora-darwin-arm64"
      sha256 "bad372f33cfd6151a7c8206de671a1c9005565d34119cb9922a5966c56646db2"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.14/khora-darwin-amd64"
      sha256 "7494c886e67a9eeb058cba2673e5befe19933f1f342ad047e9655de591905148"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.14/khora-linux-arm64"
      sha256 "bb0a80f5d907e384bce84bc27b146507ddb180e7a74aa7833a021b3199b57319"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.14/khora-linux-amd64"
      sha256 "5d6c9d9d87ae637a1f8cfa9f9a8211cda1eb7051898e7d94dcebe4e9367aa1d4"
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
