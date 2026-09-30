class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.3.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.3.0/naru-audio-darwin-arm64"
      sha256 "018f8f23f8411d000f4ba1ad64b35ec60f7cfe2a6a90c8f052ad934149d01b7d"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.3.0/naru-audio-darwin-amd64"
      sha256 "9905ea1189431d7a367b9ad2392232f4ce43cee5b1850f7e54e55255c55d7bd6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.3.0/naru-audio-linux-arm64"
      sha256 "696e4d44424bb9e81e17698250a128af7f314b5e3e85d8bd3b9255c31222a7c9"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.3.0/naru-audio-linux-amd64"
      sha256 "d92b1248ee8a965608116e8cfa1a66440b71689940565c99ebe3b0d8fb344965"
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
