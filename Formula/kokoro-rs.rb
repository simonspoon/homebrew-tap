class KokoroRs < Formula
  desc "Command-line text-to-speech with Kokoro v1.0, streaming to your speakers as it synthesises"
  homepage "https://github.com/simonspoon/kokoro-rs"
  version "0.1.2"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.2/kokoro-rs-darwin-arm64"
      sha256 "818431e61d8cb8f6da7280398444e25a083bcf0ff1b6f9e8aa1612449efa1f5b"
    else
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.2/kokoro-rs-darwin-amd64"
      sha256 "c5787e0b7a4f502d0e53f98a481a153905ef9977ec43ea576c7038683824dca6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.2/kokoro-rs-linux-arm64"
      sha256 "9c3289d85ab80f38f3b1c0b16e363c457cac929208a05b25f3b884c3da105204"
    else
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.2/kokoro-rs-linux-amd64"
      sha256 "bc612226c20d4d6b46fd42ba152dda9a5c11d89ce2b0c2429ac225dfcf367359"
    end
  end

  def install
    binary = Dir["kokoro-rs-*"].first || "kokoro-rs"
    bin.install binary => "kokoro-rs"
  end

  test do
    assert_match "kokoro-rs", shell_output("#{bin}/kokoro-rs --help")
  end
end
