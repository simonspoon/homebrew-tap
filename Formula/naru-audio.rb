class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.7.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.7.0/naru-audio-darwin-arm64"
      sha256 "4f8b5ce9fee2452b8856719d49fb548b814cf5291dd7f9b881a1cf8a3c069425"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.7.0/naru-audio-darwin-amd64"
      sha256 "4712d65ccd941609cdddfacf140b44ce2c9f036e271c4b4710788e03c26e0f54"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.7.0/naru-audio-linux-arm64"
      sha256 "5e24c6f667c7077f39eb0dbaa8adddcb7e4a56e91a658ddf08c51098d8e109f0"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.7.0/naru-audio-linux-amd64"
      sha256 "196cecd5ee072f0f69955b354c2ad4b9ba0c98fa128734a54e62c53d20d18c76"
    end
  end

  def install
    binary = Dir["naru-audio-*"].first || "naru-audio"
    bin.install binary => "naru-audio"
  end

  def caveats
    "naru-audio pull default && brew services start naru-audio"
  end

  service do
    run [opt_bin/"naru-audio", "serve"]
    keep_alive crashed: true
    process_type :interactive # audio latency; avoid background throttling
    log_path var/"log/naru-audio.log"
    error_log_path var/"log/naru-audio.log"
    environment_variables RUST_LOG: "naru_audio=info"
  end

  test do
    assert_match "Local STT/TTS daemon for Naru", shell_output("#{bin}/naru-audio --help")
  end
end
