class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.6.1"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.6.1/naru-audio-darwin-arm64"
      sha256 "1e2c7321803ee0444b4b5b8d44be22dd3074ee4c4fcab80ebd972cfff399771e"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.6.1/naru-audio-darwin-amd64"
      sha256 "9ee8cbd769e6ae6516ea4adad6bf41db02f704b63f0b11e490b1cf95b98a39d3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.6.1/naru-audio-linux-arm64"
      sha256 "ca0b9934c09d34963dd68afe6c017fad4b8c045d43a64bdb0ea1fb302cf055cc"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.6.1/naru-audio-linux-amd64"
      sha256 "043ad528bc403d10edd120e3a006c683dd33663f11697254279009118f876850"
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
