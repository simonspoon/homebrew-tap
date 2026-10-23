class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.13.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.13.0/naru-audio-darwin-arm64"
      sha256 "0b3030ceee266400a8c2c5ad18854e5c925f4ce60fd42ac3df26a5331e74089a"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.13.0/naru-audio-darwin-amd64"
      sha256 "aee879da2906cfbf739c65f69784e7496f71467356390643cddda27681e493eb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.13.0/naru-audio-linux-arm64"
      sha256 "c4bb3e0f214c491902fde3319992a475535ff8d81bda0d5b2e81e2d7760e74d6"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.13.0/naru-audio-linux-amd64"
      sha256 "1b4b601828d0f27fbfbb42b083bd6dde98adaa4dba38526c405787af6a41b6d5"
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
