class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.1/khora-darwin-arm64"
      sha256 "f3c8d05db1e2733583002d194d9ec7e266a776b4f5ea1e0dbc2aae32766ea274"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.1/khora-darwin-amd64"
      sha256 "c64997923a47ce4b20700b315fd888881b3c0b626a4eb3822a300639ef21dab8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.1/khora-linux-arm64"
      sha256 "76ff0297b0736f70c9155a580eb5b8e8c8f90dcbe4e1e7e05761517e80ff08c4"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.1/khora-linux-amd64"
      sha256 "c2370959edb6f3ac98f56b6d01587d84eb87d49b61c6c19ee0f3d1a888bdbfad"
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
