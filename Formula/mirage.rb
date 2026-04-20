class Mirage < Formula
  desc "Swagger 2.0 mock API server with SQLite-backed fake data"
  homepage "https://github.com/simonspoon/mirage"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.4.0/mirage-darwin-arm64"
      sha256 "1c5c8bbda45cdc57e6e0108552e409195b3a447b4a387a4295c635bf5600b247"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.4.0/mirage-darwin-amd64"
      sha256 "7d4a70730ee2c8d6416b44a41bad89475021a6ff0176f71f38e3c777190659e8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.4.0/mirage-linux-arm64"
      sha256 "beb4e30dc6c3479eb883cf51345f0b8ca999cbeca8c67b343a9fdc4c18f5a08a"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.4.0/mirage-linux-amd64"
      sha256 "9926c4b752f1963863a7b7d1438a4f0e0ac3ef93914f053fc9ff639a1dbf18ca"
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
