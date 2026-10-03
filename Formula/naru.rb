class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.2.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.2.0/naru-darwin-arm64"
      sha256 "330d767396480ec0f080804b469744d315c9f3de47aeaf729e2c453d488d2b56"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.2.0/naru-darwin-amd64"
      sha256 "04677fa73a84a0cd9359f9bc9bd5f68714b4c54d356acdbfd303b57af27ad796"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.2.0/naru-linux-arm64"
      sha256 "fe520cee10b7fbdb6eee164f625dd50ac76caba7b79002a444b0e6e02dd8fa60"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.2.0/naru-linux-amd64"
      sha256 "638d49b6aedaf36584a42e725e32e29d054e32dedca24f2d5e5d5703791a03ec"
    end
  end

  def install
    binary = Dir["naru-*"].first || "naru"
    bin.install binary => "naru"
  end

  test do
    assert_match "naru", shell_output("#{bin}/naru --help")
  end
end
