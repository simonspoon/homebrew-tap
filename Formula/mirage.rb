class Mirage < Formula
  desc "Swagger 2.0 mock API server with SQLite-backed fake data"
  homepage "https://github.com/simonspoon/mirage"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.0/mirage-darwin-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.0/mirage-darwin-amd64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.0/mirage-linux-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.0/mirage-linux-amd64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
