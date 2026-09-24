class Naru < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/naru"
  version "1.9.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.9.0/naru-darwin-arm64"
      sha256 "6b7131dbaa1398429d242e44c74120d0c94317604c5d77d26eb8ba32e6c53e3f"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.9.0/naru-darwin-amd64"
      sha256 "7e127598e6e9af65c9dce3fe18a21ad87d59d2e6f873e9018ea2a67b7c8b2b39"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.9.0/naru-linux-arm64"
      sha256 "337b437eb0d22ff63bcb4b1184e216fffaabbaf9e5ffb91c94a87d90eeb65bab"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.9.0/naru-linux-amd64"
      sha256 "456121cd7b298817e077d2639404aa901dfc412bc619ec43bb025fef9d02f208"
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
