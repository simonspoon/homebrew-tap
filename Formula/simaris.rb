class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.1/simaris-darwin-arm64"
      sha256 "398c5d292269071f8d11f83371302bfef785bce24e89cb4886500903d1b2ea71"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.4.1/simaris-server-darwin-arm64"
        sha256 "d136d9774b19ff513b568a4ef3289cb3a80aeed03c72a1c035367875b6c35506"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.1/simaris-darwin-amd64"
      sha256 "581b575b2a606341afc2a2000779f155284ade8847ad31f772119b07cfe7c562"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.4.1/simaris-server-darwin-amd64"
        sha256 "214077eddb7ec8d8da9cd4a267f7b4734430dee580c3b92ddd28a214ff464d05"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.1/simaris-linux-arm64"
      sha256 "7caeeb6c5556073c34d62a4e90943eabf11a1d8d08577713eb50c07e799b8be5"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.4.1/simaris-server-linux-arm64"
        sha256 "e83d2f70a2618ae223a0081cb32d608e7fba5352fda32bed983ae9ec523e6cf7"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.4.1/simaris-linux-amd64"
      sha256 "0e89bbd9aa82f4f6a7d2f8ab26ab0149a30a2085a0394c619876f4fba8524556"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.4.1/simaris-server-linux-amd64"
        sha256 "810df63b2b4aef4b390b799590b96c7780b821246536a8cda1b876edb5319acb"
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
