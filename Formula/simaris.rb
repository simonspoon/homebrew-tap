class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.10.0"
  license "MIT"

  # Intel Mac binaries built locally (host-native cargo build); CI cannot
  # cross-compile to x86_64-apple-darwin because lance-index references an
  # AVX-512 intrinsic that the Apple Intel link path cannot resolve, even
  # though it is a runtime-dispatched code path. See M5.7 sitrep.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.10.0/simaris-darwin-arm64"
      sha256 "bedfb991c85d3937168c83c6a7426ec5d99f94d11da093967440b35cca795694"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.10.0/simaris-server-darwin-arm64"
        sha256 "ecb6900a6b9a6aaae631dbb3dd93d0af8c3e75ba24e1db0be6a672a0d5fd63b9"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.10.0/simaris-darwin-amd64"
      sha256 "a23ce695e985523fa9c1fd3603da61cf4702f67877439cbe1046279ee4be06de"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.10.0/simaris-server-darwin-amd64"
        sha256 "e187b70d59a781399f318474eece7e05c4acf00e602385170ef2e12c1da59d8d"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.10.0/simaris-linux-arm64"
      sha256 "17855ed2fa9d4606c389485323ea38b155e11cafe9571e330bc829ba36cadd45"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.10.0/simaris-server-linux-arm64"
        sha256 "7f87c52ad7786bc8f79ad2497cf83bdcf81d9c85f95d81ede84adad8569a9253"
      end
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.10.0/simaris-linux-amd64"
      sha256 "8c7ebf3882ecc736d06b41f5f57c493b69b0bdd985e23ece032cc008b407dea7"
      resource "server" do
        url "https://github.com/simonspoon/simaris/releases/download/v0.10.0/simaris-server-linux-amd64"
        sha256 "cfa0fde63c799093a96f7cdf49b083fcccf6d30063005412b6d48e07eeff61c2"
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
