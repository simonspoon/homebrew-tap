class Mirage < Formula
  desc "Swagger 2.0 mock API server with SQLite-backed fake data"
  homepage "https://github.com/simonspoon/mirage"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.6.0/mirage-darwin-arm64"
      sha256 "e69716b84805de07dcfa31c8b7b8c86960671d95a83de0fd52d6731944d284c2"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.6.0/mirage-darwin-amd64"
      sha256 "79ffe18eb18299805e4241e8f0a915f0ec58eed689f750ecfc303a733582ad8e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.6.0/mirage-linux-arm64"
      sha256 "445d91655a4c2ed86d4f6022c3aad6c16be043738b9a125ef11224ebc78e2af2"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.6.0/mirage-linux-amd64"
      sha256 "b7454cb9e16150074b7a494ff557c657c088ba14e79e05945e35f5a11d7b2e0f"
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
