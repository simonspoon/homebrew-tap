class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.5.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.1/simaris-darwin-arm64"
      sha256 "3ed4adfcdf09601922867323a04e826f467941378188f816233bc1564021c603"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.1/simaris-server-darwin-arm64"
        sha256 "2630d0a7b6ad1473adb985d866cbdf5b9fc35c1ba34deedb035a9b5f1afa5f11"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.1/simaris-darwin-amd64"
      sha256 "304b3acc585b26f0a0cc2fba06d2a3e787f63e0458e19724255dd23ce006beca"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.1/simaris-server-darwin-amd64"
        sha256 "dd38da6189e4afb918899c5f94a4ed389514da97e5aeee1dea0d66e02073f9af"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.1/simaris-linux-arm64"
      sha256 "d082f66cd327267f4307d12395392e7e6ecb4a6051a502726f0d9bc875629017"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.1/simaris-server-linux-arm64"
        sha256 "7773622786a24664d29e4fa5a1fcf0cb3b35871a454c2a44959bcf66b9aac228"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.1/simaris-linux-amd64"
      sha256 "5c851a8557b2cf9e6f9c89e6bbf04ad0cff3111648ec3e98183cc4aeee057016"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.1/simaris-server-linux-amd64"
        sha256 "3065a21ac3fe261a1090d29de399f4f3c78817ce1f0ddddf5f54171dfcea05a2"
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
