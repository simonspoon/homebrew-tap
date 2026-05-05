class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.5.2"
  license "MIT"

  # Intel Mac (x86_64-apple-darwin) is unsupported from v0.6.0+ — lance index
  # uses AVX-512 intrinsics that the Apple Intel toolchain cannot link.
  # Apple Silicon Macs use the native arm64 build below. Intel Mac users:
  # pin to v0.5.2 (FTS5-only) or use Linux via x86 emulation.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.2/simaris-darwin-arm64"
      sha256 "42f59a0b3832bd8241f854566aafc5dc64ece128105044a4e03dd31abd384cea"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.2/simaris-server-darwin-arm64"
        sha256 "cc177abaf16e1ec5280adf115f17c03a996d2d212ed25ec23b7cc4eac5bffea6"
      end
    else
      odie "simaris v0.6.0+ does not support Intel Macs (lance AVX-512 link issue). Pin to v0.5.2 or use the Linux build under x86 emulation."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.2/simaris-linux-arm64"
      sha256 "15c54954c372afbdc4d66bbfee1853a578a72d135a3a3fb36e6a57450babe818"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.2/simaris-server-linux-arm64"
        sha256 "eaad9a87c2e4a30574f117921a4a70ea08eb4f10d7c7e038d69cacbbfeb2edd1"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.2/simaris-linux-amd64"
      sha256 "32808adc9551aa0b2948172899ddfc837ed6e12c2fc7033befbef5d556bcd02f"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.2/simaris-server-linux-amd64"
        sha256 "443790ac4b737177ac6ce4c98ef1ffed74e3d38cafcc844b3b147dfb0eb62b91"
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
