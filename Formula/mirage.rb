class Mirage < Formula
  desc "Swagger 2.0 mock API server with SQLite-backed fake data"
  homepage "https://github.com/simonspoon/mirage"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.0/mirage-darwin-arm64"
      sha256 "2837aeb03ae11956f4fefbcf3879f52613d82ce19c20d9871370e1aade80e9c2"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.0/mirage-darwin-amd64"
      sha256 "868ed5be527dc245ed66258035eb6bc796f75cc719f054a190620ee7f63d0dd4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.0/mirage-linux-arm64"
      sha256 "e84b2a6345330377aaae197db4a9e30a3dc83714ba710e1dc5a516337b5760c2"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.1.0/mirage-linux-amd64"
      sha256 "971bfef0cc8a352cc8370ccabf90126a2039dfd8901ea537e8cf376712b4fbfd"
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
