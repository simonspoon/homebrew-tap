class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.14.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.14.0/naru-audio-darwin-arm64"
      sha256 "01b400d2a76adada758818865210101ac08e57885a67dadb33bfc8871bfc75d6"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.14.0/naru-audio-darwin-amd64"
      sha256 "8e22f2b31bcec96b0e96037ee3bf5d677ebbd4b2a95890648714b180cedd2902"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.14.0/naru-audio-linux-arm64"
      sha256 "938516843af2095ab50d9fdb930400a207b876f93b6021bca40476b3eacea9db"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.14.0/naru-audio-linux-amd64"
      sha256 "609794bd8b5beaec6e3475170808a5f2a2c3235c84a4b50e498f89b2d28204e5"
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
