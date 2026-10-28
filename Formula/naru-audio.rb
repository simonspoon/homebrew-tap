class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.15.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.15.0/naru-audio-darwin-arm64"
      sha256 "a80c7e742fb75952e154eff7059b28f7b502c4677fde748311ddd9b30903e93a"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.15.0/naru-audio-darwin-amd64"
      sha256 "d88b93a6bda5a89166dd940e4db11ce17e5f5d9185cd40d5177dee63599baf17"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.15.0/naru-audio-linux-arm64"
      sha256 "b278ea58210334540df9f443dc9581adb91eff7b02147544fc98168111766914"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.15.0/naru-audio-linux-amd64"
      sha256 "ba7c6d36ca44e576c85284d46aa92a15c654ad18ecd7f79ede8adfae9f066f27"
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
