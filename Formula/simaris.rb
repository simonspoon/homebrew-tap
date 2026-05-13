class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.9.0"
  license "MIT"

  # Intel Mac binaries built locally (host-native cargo build); CI cannot
  # cross-compile to x86_64-apple-darwin because lance-index references an
  # AVX-512 intrinsic that the Apple Intel link path cannot resolve, even
  # though it is a runtime-dispatched code path. See M5.7 sitrep.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.9.0/simaris-darwin-arm64"
      sha256 "c3bf13da0748b0681e60df02e38e07ecb09749b188874dffaca232c6dcb53a5b"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.9.0/simaris-server-darwin-arm64"
        sha256 "ef0a07d76bd752e3168a94e87e11fc14ceebf31aeb0b27e8e568d1ff5b08cdab"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.9.0/simaris-darwin-amd64"
      sha256 "dfad5908282b551d4f8a430b68d615fe57905d6e89d62bd4e366afc7303c052d"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.9.0/simaris-server-darwin-amd64"
        sha256 "d06849b844739d633269e6838bd2a0818919ba7df242ce9a4114faad414e65bd"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.9.0/simaris-linux-arm64"
      sha256 "5fca52ee92c5ee2d2a6d959a63e7439de51b0878e2336f959329ad067a986f36"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.9.0/simaris-server-linux-arm64"
        sha256 "e9f3fd530dae7818bcc203e18c1c7a55009b9ca960c195a241c5743103125c08"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.9.0/simaris-linux-amd64"
      sha256 "c6ea3a0533e0dc3c1975d6d5f6d6a52b17bd0a264d2a6f61302cbe1d7c1f58d1"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.9.0/simaris-server-linux-amd64"
        sha256 "1479f26457099ca613d7247e10644d866c85041cf4164679f6f8f2ad8bfcf5d5"
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
