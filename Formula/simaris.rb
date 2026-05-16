class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.12.0"
  license "MIT"

  # Intel Mac binaries built locally (host-native cargo build); CI cannot
  # cross-compile to x86_64-apple-darwin because lance-index references an
  # AVX-512 intrinsic that the Apple Intel link path cannot resolve, even
  # though it is a runtime-dispatched code path. See M5.7 sitrep.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.12.0/simaris-darwin-arm64"
      sha256 "bd34d982c7e3924dd523826d91f2487bb9922867653162b5fe7ddc4fb76c3bd4"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.12.0/simaris-server-darwin-arm64"
        sha256 "4b6e6e4c3f183f137479f3716d2f2aee1003b1a5e59f0310d9136d9c2a436dfb"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.12.0/simaris-darwin-amd64"
      sha256 "cdbb521d566305cc9b6e00801335570ce18a79c7ebfb710a836338cbde344607"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.12.0/simaris-server-darwin-amd64"
        sha256 "04bcf4855f160b9c8fa4ab7b7382ec307acc88083245f61ddb0f79db9b5d33d2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.12.0/simaris-linux-arm64"
      sha256 "234cf43031514358962c108ef10c478057c1586f6a40bb3b2f0c7d9f365a0c51"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.12.0/simaris-server-linux-arm64"
        sha256 "7b03da8acd3b2792907af81e1817c5b27e26e085188a85135701d014e2e3f931"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.12.0/simaris-linux-amd64"
      sha256 "116c287c64b3f7c7b985a86617af245630976f219159c64b20baea77c6ca86a4"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.12.0/simaris-server-linux-amd64"
        sha256 "58495a670e8d82ac7c7c79bf295e9d35c61ee33bd9fdb5e638cda9ad3c7789ed"
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
