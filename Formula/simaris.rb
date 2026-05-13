class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.8.0"
  license "MIT"

  # Intel Mac binaries built locally (host-native cargo build); CI cannot
  # cross-compile to x86_64-apple-darwin because lance-index references an
  # AVX-512 intrinsic that the Apple Intel link path cannot resolve, even
  # though it is a runtime-dispatched code path. See M5.7 sitrep.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.8.0/simaris-darwin-arm64"
      sha256 "fde7e0c396fd983380e2f29129b5be61093cb02a5e7a73f1af2883968ddc0ffa"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.8.0/simaris-server-darwin-arm64"
        sha256 "8775e0992e32afda5ddde3de59acadf7e15847102d4c1c842bff1831c500ac91"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.8.0/simaris-darwin-amd64"
      sha256 "f3b84b4d3cc0e5da0996f062d02c8537e62265c4885af20950ce98c7e95eae55"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.8.0/simaris-server-darwin-amd64"
        sha256 "d850333db0922dc4034b91b79e8bf07243682933fc5d393b64965429999fa3dc"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.8.0/simaris-linux-arm64"
      sha256 "04dc299676db3499df80fb2895990a9d78e5c47f19588ca6de760970608841e2"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.8.0/simaris-server-linux-arm64"
        sha256 "4ea9eed792063521e74b261553f50b4201ea2dfe334d9bacb1feb276ccbeed46"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.8.0/simaris-linux-amd64"
      sha256 "57b1aae84fdaed40e3658246852266724207ad4119d6e03efc762547c78df58a"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.8.0/simaris-server-linux-amd64"
        sha256 "0e96e332264fd3da97fa37ed870b254c57c2e6be30cbe91195dc4d44c3ebb638"
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
