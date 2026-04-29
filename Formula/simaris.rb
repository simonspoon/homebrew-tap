class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-darwin-arm64"
      sha256 "35f6df21ee56a814e4319ab1f4d90fcf17cf1b0283c8519048691bdd2f2099aa"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-darwin-amd64"
      sha256 "a8773dc41e3e4507ee73c97aad217ed1ce3f8bb92cfb1b4ff9d76a0109aea5b5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-linux-arm64"
      sha256 "8093ecef59e68048c13e28f6b9927f932ce5e51af0179a3c404fcced7b945333"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-linux-amd64"
      sha256 "3e79e95c73d6eb7def2547dca271cc0f34c81b067ae7995e063d7312e83e82d7"
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
