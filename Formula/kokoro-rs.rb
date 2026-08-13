class KokoroRs < Formula
  desc "Command-line text-to-speech with Kokoro v1.0, streaming to your speakers as it synthesises"
  homepage "https://github.com/simonspoon/kokoro-rs"
  version "0.1.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.0/kokoro-rs-darwin-arm64"
      sha256 "6743a8a3384e3baeef5e632ee4c822d5053d3abb0910eef4122b0215790e2274"
    else
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.0/kokoro-rs-darwin-amd64"
      sha256 "94c0a60892a6e71d52cf60945244c5370e4e9f12ece17b4e70bbde14afefcd07"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.0/kokoro-rs-linux-arm64"
      sha256 "f16fab9cf4457d009557fa82b70ebdf03405e9082bba605e393922b861b52897"
    else
      url "https://github.com/simonspoon/kokoro-rs/releases/download/v0.1.0/kokoro-rs-linux-amd64"
      sha256 "70a371b5ce4585b0977bb1e4794634bca6249f7674481f8bf87865976a9a71dd"
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
