class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.1.1/khora-darwin-arm64"
      sha256 "4fddb2254a5eb430780688d10b2a2ed8800323525ff6a09de3fefeb6d7adeae0"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.1.1/khora-darwin-amd64"
      sha256 "17e2c7e3a863d29308060d706f60f142df0901077adc7b2dfb234db1a4337ddb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.1.1/khora-linux-arm64"
      sha256 "c642d7d67bebfa4a9fb0e0fb2d9f1cc636033d51d441d5403e6a685302dbe7ca"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.1.1/khora-linux-amd64"
      sha256 "17b18825a5ee87ad2ce4d3112180403ff0dcb8e57c25f356f8635b326b092836"
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
