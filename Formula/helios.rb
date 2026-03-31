class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.14.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.14.0/helios-darwin-arm64"
      sha256 "5b6d41385d055245f76eb2c7ec45ab4ab7e99bac1b3b5a5a493e9fb83fbaa8e3"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.14.0/helios-darwin-amd64"
      sha256 "5867365860d843e4577ca3cc39f9baa7391fa9ca34a6bfb974fc2ab5225c3ef8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.14.0/helios-linux-arm64"
      sha256 "04d9186dfed679d6ad429e4647940e13d5b4afe9b7c84f60b12a30aeed2e62c6"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.14.0/helios-linux-amd64"
      sha256 "048ad8de060ceb1695caa97bcc6bdcbda9274dc64522724b83a2590b70edea57"
    end
  end

  def install
    binary = Dir["helios-*"].first || "helios"
    bin.install binary => "helios"
  end

  test do
    assert_match "helios", shell_output("#{bin}/helios --help")
  end
end
