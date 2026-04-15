class Mirage < Formula
  desc "Swagger 2.0 mock API server with SQLite-backed fake data"
  homepage "https://github.com/simonspoon/mirage"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.2.0/mirage-darwin-arm64"
      sha256 "ecf883b93332444f64b6c22db0dd2e42173be44168e27f6dd5fd204c369257b5"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.2.0/mirage-darwin-amd64"
      sha256 "1dee95225b97dcfb139fe8ff29f94a72fc02314c89e56c62e3b6ed9ff164a486"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.2.0/mirage-linux-arm64"
      sha256 "5d75bca8d29b46e57c9909a26eb8f1f53b2f007dc6692ded52503403fcdd9504"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.2.0/mirage-linux-amd64"
      sha256 "16715932713d397a2153a0107523c98efe15740b957f494b723031ab1e36ad34"
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
