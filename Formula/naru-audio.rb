class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.10.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.10.0/naru-audio-darwin-arm64"
      sha256 "9cab8d98ca5102570a05d18b305a969b33e2e9e0ecb51ead031c0b2ccacf340c"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.10.0/naru-audio-darwin-amd64"
      sha256 "c8024da024af7bfc1f09fc6369c8c63c4d1bf1bbf628337b5ff585e90e7b77a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.10.0/naru-audio-linux-arm64"
      sha256 "c3d956cd220e8d1857d72d358b1c844bda6ef666bb16ff0547e621d39c100bbd"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.10.0/naru-audio-linux-amd64"
      sha256 "f8f0ca12287a859e452607b6a1f9189b813d4221f56c0aa615437b9ee0c2a173"
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
