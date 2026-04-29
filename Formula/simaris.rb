class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-darwin-arm64"
      sha256 "35f6df21ee56a814e4319ab1f4d90fcf17cf1b0283c8519048691bdd2f2099aa"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-server-darwin-arm64"
        sha256 "8143f14cfd7e9df9508552debaa50e3e3fd2345bdbf0b4661066a412a737dab5"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-darwin-amd64"
      sha256 "a8773dc41e3e4507ee73c97aad217ed1ce3f8bb92cfb1b4ff9d76a0109aea5b5"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-server-darwin-amd64"
        sha256 "8f81c15b171fb6a035538d365e71817441c54abb86ef288cfdf0647ffbfb0c91"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-linux-arm64"
      sha256 "8093ecef59e68048c13e28f6b9927f932ce5e51af0179a3c404fcced7b945333"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-server-linux-arm64"
        sha256 "43465909636f16882f1103e5874824f82c8dd15e1c4ba03bda41411d6a64595a"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-linux-amd64"
      sha256 "3e79e95c73d6eb7def2547dca271cc0f34c81b067ae7995e063d7312e83e82d7"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.4.0/simaris-server-linux-amd64"
        sha256 "77c0865aefd6ccec60a86b9575fb2c11280a0ac2c168f336b4fb10fd39cbcb97"
      end
    end
  end

  def install
    cli = Dir["simaris-*"].find { |f| !f.include?("server") } || "simaris"
    bin.install cli => "simaris"

    resource("server").stage do
      server_bin = Dir["simaris-server-*"].first
      bin.install server_bin => "simaris-server"
    end
  end

  test do
    assert_match "simaris", shell_output("#{bin}/simaris --help")
    assert_predicate bin/"simaris-server", :executable?
  end
end
