class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.12.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.12.0/naru-audio-darwin-arm64"
      sha256 "0ea8ecafb124845f94662bc2c72b0c24b4df996346b0311d8b0efda73552f70e"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.12.0/naru-audio-darwin-amd64"
      sha256 "33c6b6243d917f1504043aab246ecef9d52829336ff346a6f56b812272ef9790"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.12.0/naru-audio-linux-arm64"
      sha256 "5e7a95f250570b1d6915a5fb8e48e021dab02d0cc997b1a14370906244a435df"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.12.0/naru-audio-linux-amd64"
      sha256 "07ab7b3e03faa82ebe58ac4da7c31bc990c4a4dc45490755e977bdeba160d760"
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
