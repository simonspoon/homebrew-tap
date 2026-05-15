class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.11.0"
  license "MIT"

  # Intel Mac binaries built locally (host-native cargo build); CI cannot
  # cross-compile to x86_64-apple-darwin because lance-index references an
  # AVX-512 intrinsic that the Apple Intel link path cannot resolve, even
  # though it is a runtime-dispatched code path. See M5.7 sitrep.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.11.0/simaris-darwin-arm64"
      sha256 "0619e1e2a616ef733a11e53bedb096853eb15e79c369f206081d792a11092776"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.11.0/simaris-server-darwin-arm64"
        sha256 "ba116e927c19e7eb6c128361091bbb69dc186bedb0c07ecef68fa7d079a4a570"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.11.0/simaris-darwin-amd64"
      sha256 "949c8c4f31db430c5963a60a36a02fdfd7555419e98d78a21f487491a6719ce9"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.11.0/simaris-server-darwin-amd64"
        sha256 "b08b5f3c72dee268a9f9f3216b5bfddc235747c323d561f201123ce74a028b42"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.11.0/simaris-linux-arm64"
      sha256 "e7cc409b29b024176bb169b0a2830460bf9d0ff29d1ba9fdce9c0cce7a38ffba"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.11.0/simaris-server-linux-arm64"
        sha256 "b5dd0ee7962c95bff2e9adc836295cb32bdb1a99bdc53b29280b9eddc1e58698"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.11.0/simaris-linux-amd64"
      sha256 "47511fbbdc26b1850b90cda81f68ed07f17141fc7c63614c4e7cba0860f00aff"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.11.0/simaris-server-linux-amd64"
        sha256 "c2303c6112212108889860e424d020f8475448fefd90a55f33150bccce2c1df1"
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
