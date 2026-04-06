class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.6.0/limbo-darwin-arm64"
      sha256 "e9f69996348636d47ecd7abf89ece79b0b6c720af89328214ea5409a48f09e85"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.6.0/limbo-darwin-amd64"
      sha256 "0d2a2b8eda6b506f794ea7ba6d83a8921837afc9ad004c4a16f37039b3943ce1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.6.0/limbo-linux-arm64"
      sha256 "e50dd403272c94ac195aff53b6d1b0ff4adf62fa154160901dd8771ac9bd91ac"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.6.0/limbo-linux-amd64"
      sha256 "643f752e3d83f854a85e38cf766318c993ca53253ce232dcb027d5c0f2fb1821"
    end
  end

  def install
    binary = Dir["limbo-*"].first || "limbo"
    bin.install binary => "limbo"
  end

  test do
    assert_match "limbo", shell_output("#{bin}/limbo --help")
  end
end
