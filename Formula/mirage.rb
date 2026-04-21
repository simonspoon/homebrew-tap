class Mirage < Formula
  desc "Swagger 2.0 mock API server with SQLite-backed fake data"
  homepage "https://github.com/simonspoon/mirage"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.5.0/mirage-darwin-arm64"
      sha256 "9db1f80d88e980e4de5b761bb4e1e74ce232b79f048bde58eae85f049185e054"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.5.0/mirage-darwin-amd64"
      sha256 "a37476f5736ac3853e1521064db9c675ee5f179627c92806f02ff73b2dce5012"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.5.0/mirage-linux-arm64"
      sha256 "754699d9d3f5dd77ca4eca9c0c986ed5fd8875d6f0d8af965f4422cb9a5f0631"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.5.0/mirage-linux-amd64"
      sha256 "5c9dda4424d638daf11305e59edb3930b9f7228ca673f2808c18e31d076934d9"
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
