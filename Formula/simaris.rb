class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.7.1"
  license "MIT"

  # Intel Mac binaries built locally (host-native cargo build); CI cannot
  # cross-compile to x86_64-apple-darwin because lance-index references an
  # AVX-512 intrinsic that the Apple Intel link path cannot resolve, even
  # though it is a runtime-dispatched code path. See M5.7 sitrep.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.7.1/simaris-darwin-arm64"
      sha256 "bda58f4ef3fa84efa535a9206cf006052a524a380979f1091318626dca7258e2"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.7.1/simaris-server-darwin-arm64"
        sha256 "077112a663e0c3259f9dd889f80bf0c975b9edeb3d8288892ad73aabec20784a"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.7.1/simaris-darwin-amd64"
      sha256 "b7f3438b448a47a158947c54c047a62001a34ef37b51d5a400d8346e9176a69c"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.7.1/simaris-server-darwin-amd64"
        sha256 "a2d2cb7c992a5287727628f948ddc3e3705591bb9734e8a57ccf124b776929d2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.7.1/simaris-linux-arm64"
      sha256 "73260bdc5f8cfe533953d652df0d67530587c3dee83797d56812c51af65ba7b8"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.7.1/simaris-server-linux-arm64"
        sha256 "a6a97ae75e04fa6b4a650b32eab1735dfcd283afd286385918b2cd9d7958db1b"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.7.1/simaris-linux-amd64"
      sha256 "f9a1369bed37e33735ee12ab3d350537676a119c55c7e6acb64859c4a195f8ff"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.7.1/simaris-server-linux-amd64"
        sha256 "14ceb55b645ee6f19b80e744d404c3903ccf9ae8e52e6193b1f7feb3802b3611"
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
