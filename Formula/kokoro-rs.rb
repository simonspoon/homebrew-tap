class KokoroRs < Formula
  desc "Command-line text-to-speech with Kokoro v1.0, streaming to your speakers as it synthesises"
  homepage "https://github.com/simonspoon/kokoro-rs"
  version "0.1.1"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.1/kokoro-rs-darwin-arm64"
      sha256 "fb2968be95aa2a8bbe79a4fa31d4157910c06cc245ec6841dd341fe504c1133d"
    else
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.1/kokoro-rs-darwin-amd64"
      sha256 "00a45a0b9495559f6cd8aca4a9c6ad34c3dbe15d33edfdea6e8cbe995785e546"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.1/kokoro-rs-linux-arm64"
      sha256 "5814fb4eb674136e571af4b42712777ba73b7749a599ec607e41f20148f380a5"
    else
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.1/kokoro-rs-linux-amd64"
      sha256 "2d6e653b44a4b614b8f200f9a1c380e9212981672e02f6503d69448b826e9924"
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
