class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.11.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.11.0/naru-audio-darwin-arm64"
      sha256 "acae96af4174000bd230c1587c9d5861c9bf7a3af3bff9b91e47532ecc69e0d0"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.11.0/naru-audio-darwin-amd64"
      sha256 "48f1b3a910a5a3e7e1f1c2964289c1e39037bded88f45e6480ccabcfe2d374e7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.11.0/naru-audio-linux-arm64"
      sha256 "1ed8435755fdd40d1b3916aaadf671dff931aa4ad596f0e8c61f3450e53c1e26"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.11.0/naru-audio-linux-amd64"
      sha256 "7eca2eabb9b5d03a9ad089b3192f0a2df8967aa51206e20135a321cd30841cf9"
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
