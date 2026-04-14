class Mirage < Formula
  desc "Swagger 2.0 mock API server with SQLite-backed fake data"
  homepage "https://github.com/simonspoon/mirage"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.1/mirage-darwin-arm64"
      sha256 "5c0807e548e32b94bb1b35da85621b44d0fe1d4e121e104644da4a31a96e34fc"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.1/mirage-darwin-amd64"
      sha256 "ca9a698a8617190c126d4d3f687b854d25aaca469bb9dec48c52fe26075b5c87"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.1/mirage-linux-arm64"
      sha256 "d6f2bee826dc833a9b01cf4d1f2fdcb60b643180f988d1bb089003af4ec767b6"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.1/mirage-linux-amd64"
      sha256 "7b349950d824aaf5830b0c55842b09bfb45fc5c1a824ab5c83ab711f00c10c38"
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
