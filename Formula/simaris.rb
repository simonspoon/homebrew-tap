class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.13.0"
  license "MIT"

  # Intel Mac binaries built locally (host-native cargo build); CI cannot
  # cross-compile to x86_64-apple-darwin because lance-index references an
  # AVX-512 intrinsic that the Apple Intel link path cannot resolve, even
  # though it is a runtime-dispatched code path. See M5.7 sitrep.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.13.0/simaris-darwin-arm64"
      sha256 "75629c42fe76f207ce83cd0ca758de2ca75c395af3658419d1c93877e0cfdf10"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.13.0/simaris-server-darwin-arm64"
        sha256 "3a0690ef612b5651af21e4342ae4c8cddb23a92f1e0f02bc13b1f70409a21485"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.13.0/simaris-darwin-amd64"
      sha256 "a1d8c40cb635bc70c443ff0553fd68053d49e0c470c1beb46f0fd2403ed04de4"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.13.0/simaris-server-darwin-amd64"
        sha256 "decb6bc23a2fd2dd914f1223e1eed56640e1b0113d9bf94b9dcf55d6bd157860"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.13.0/simaris-linux-arm64"
      sha256 "21d7816bd5f24c6800a09481bc872b0d17a55ea62b9f74acd22df753fc3d739e"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.13.0/simaris-server-linux-arm64"
        sha256 "db5864efe678c2c091de32818c1d048d3e6960605c914575d0e77936800cc359"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.13.0/simaris-linux-amd64"
      sha256 "f11e132bdf90cdb1334d4713352db0ced7cc4ac8e29f44af273bbaec63e041c1"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.13.0/simaris-server-linux-amd64"
        sha256 "604a5367d01c2c5c5c4a1250927f5b582f1f229836bb0b18a2101db4f7a835ba"
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
