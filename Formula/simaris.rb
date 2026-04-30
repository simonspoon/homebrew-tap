class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.0/simaris-darwin-arm64"
      sha256 "7d04aba977eef91ad5867ccafcd3c4100a38621e7f2622652764df78feb5996a"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.0/simaris-server-darwin-arm64"
        sha256 "90a65e61746ee4b6507228b01a14f030a66df3ecba95d56d469eeb773834a44b"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.0/simaris-darwin-amd64"
      sha256 "13bfa771b6caa99912346a4125bfd83e0520b0987576cd9dfa7c0c0e3286231b"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.0/simaris-server-darwin-amd64"
        sha256 "af20b0dea36033fd1e2cea0f85cc63b6734371056be3241be681464c17de13df"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.0/simaris-linux-arm64"
      sha256 "06222fd3fca8db1f1197c35fa2131facafd279526ab59156007b8571b356fbb8"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.0/simaris-server-linux-arm64"
        sha256 "ae735c8df442ea9c25704eade083564994d886cc083e8341e2d488342e739138"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.0/simaris-linux-amd64"
      sha256 "f9baf1c92b7c9805baf4c28ceefa854181376a1cfbe0747d734d90dbf1d12f02"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.0/simaris-server-linux-amd64"
        sha256 "29ff0376a76e341e90e2a26151b905c8c7657722bf6e79d18cd353381a5a4647"
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
