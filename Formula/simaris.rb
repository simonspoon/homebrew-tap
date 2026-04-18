class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.2.0/simaris-darwin-arm64"
      sha256 "b561e0025a351d7cbdd0e09b9fe268aafa76227231dfa2bc6a3af370876877fd"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.2.0/simaris-darwin-amd64"
      sha256 "99fc57cafc493e2b1d3724197dc199fc17fb321248eceaa0b6a8c6e79731db89"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.2.0/simaris-linux-arm64"
      sha256 "7124d01134e1477218859c3f3e560473c39b802d5b8a9663ec9ccfd211fae64e"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.2.0/simaris-linux-amd64"
      sha256 "a98458553a24c4ec4d5b100f96682d36dfddc4dd944d7091179e9cabe9eb5a1b"
    end
  end

  def install
    binary = Dir["simaris-*"].first || "simaris"
    bin.install binary => "simaris"
  end

  test do
    assert_match "simaris", shell_output("#{bin}/simaris --help")
  end
end
