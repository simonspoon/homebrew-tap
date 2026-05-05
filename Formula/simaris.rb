class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.6.0"
  license "MIT"

  # Intel Mac binaries built locally (host-native cargo build); CI cannot
  # cross-compile to x86_64-apple-darwin because lance-index references an
  # AVX-512 intrinsic that the Apple Intel link path cannot resolve, even
  # though it is a runtime-dispatched code path. See M5.7 sitrep.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.6.0/simaris-darwin-arm64"
      sha256 "869d20d4bac1f80982d1acad06faf225a7342ff284011394e65a59715cd112ff"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.6.0/simaris-server-darwin-arm64"
        sha256 "e4ad0219299996cb86bdb86bc24d3af82c86a38218a95683b838a51c556e324c"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.6.0/simaris-darwin-amd64"
      sha256 "e231ec6ad5728de144d30af70a763f27a244b01eb8537287379cc97f4071b699"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.6.0/simaris-server-darwin-amd64"
        sha256 "a2d2cb7c992a5287727628f948ddc3e3705591bb9734e8a57ccf124b776929d2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.6.0/simaris-linux-arm64"
      sha256 "a041a363161c734aa05858958c214790c6fa8b17643dc5d7776c3d9d83f6732f"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.6.0/simaris-server-linux-arm64"
        sha256 "cbd9c27ceda709b5f3cc397954923eaf704fe6211cd8941b21bae7e61520e168"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.6.0/simaris-linux-amd64"
      sha256 "ff39ba1a0d1a9d82d23c00fcd50e02301ea5bd3f1e1689759df9e989e579d963"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.6.0/simaris-server-linux-amd64"
        sha256 "33b1ee77cc222ed51e72c7460c7e8d658e700e6fbe6f614f0484fb0512a37cc3"
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
