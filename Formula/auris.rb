class Auris < Formula
  desc "Command-line speech-to-text with Parakeet TDT 0.6B v2, transcribing audio from stdin"
  homepage "https://github.com/simonspoon/auris"
  version "0.1.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/auris/releases/download/v0.1.0/auris-darwin-arm64"
      sha256 "8f41123dc254d59a69e471287dc93823332c65aa5af37a83478fba9269b04a1e"
    else
      url "https://github.com/simonspoon/auris/releases/download/v0.1.0/auris-darwin-amd64"
      sha256 "fc8ad1ab5969abe054e39934aba1f0a12f72675145df64ea5c0f90715ca657d2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/auris/releases/download/v0.1.0/auris-linux-arm64"
      sha256 "526a974477e957299f4bd2a94103b65ea167f871dd76737fd146ae63b388bb53"
    else
      url "https://github.com/simonspoon/auris/releases/download/v0.1.0/auris-linux-amd64"
      sha256 "b785a6785857edcdf52cd10f8c3140556e3eb4abfc4f7522441d02bbd9b30ec0"
    end
  end

  def install
    binary = Dir["auris-*"].first || "auris"
    bin.install binary => "auris"
  end

  test do
    assert_match "Speech-to-text", shell_output("#{bin}/auris --help")
  end
end
