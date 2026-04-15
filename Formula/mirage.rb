class Mirage < Formula
  desc "Swagger 2.0 mock API server with SQLite-backed fake data"
  homepage "https://github.com/simonspoon/mirage"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.3.0/mirage-darwin-arm64"
      sha256 "a5566753e6ba7423444a1091186d66b6bdc0491828439535dbef2d5007f05949"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.3.0/mirage-darwin-amd64"
      sha256 "4f3da9079a33db35718990f4382788acdc965b8777134a3ac3076ac58a398951"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.3.0/mirage-linux-arm64"
      sha256 "13d9d15937fdc805ddd443d290b126a2c9d1f627c721970b1883dd042391dc28"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.3.0/mirage-linux-amd64"
      sha256 "a8e280bf04cdc2bc368469a96205f9e921d72b8cf2a0963f28fbed58e92f08ed"
    end
  end

  def install
    binary = Dir["mirage-*"].first || "mirage"
    bin.install binary => "mirage"
  end

  test do
    assert_match "Swagger 2.0 mock API server", shell_output("#{bin}/mirage --help")
  end
end
