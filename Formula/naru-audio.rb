class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.4.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.4.0/naru-audio-darwin-arm64"
      sha256 "9c074b77477a70035f5f1bb529c6c7d77304bcfc3d36d801efe3c276a8b07c5b"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.4.0/naru-audio-darwin-amd64"
      sha256 "2d9b0fc7985c2e43840c7b5381f55419ea0cc3b4666b2bda85c9f67b8f211292"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.4.0/naru-audio-linux-arm64"
      sha256 "b063c2c394ac8d2dd877974743fde30aab1629d93445ac59bafbb9a89881c646"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.4.0/naru-audio-linux-amd64"
      sha256 "fecc5a16c4cf49a3b6e838954dd73ce825f8c247c60d752cb8a37b25b065d708"
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
