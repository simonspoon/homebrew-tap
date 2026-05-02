class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.5.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.2/simaris-darwin-arm64"
      sha256 "42f59a0b3832bd8241f854566aafc5dc64ece128105044a4e03dd31abd384cea"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.2/simaris-server-darwin-arm64"
        sha256 "cc177abaf16e1ec5280adf115f17c03a996d2d212ed25ec23b7cc4eac5bffea6"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.5.2/simaris-darwin-amd64"
      sha256 "4a3dc23ca4bd7e3590c5beb0036b449fdfd270a893ce7434ca7b46a89ffdb743"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.5.2/simaris-server-darwin-amd64"
        sha256 "5a4a9e17ea8a58d6b194c6f0fd2deb07d50e6a00088d7f8db3c19cfcb4b7bea5"
      end
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
