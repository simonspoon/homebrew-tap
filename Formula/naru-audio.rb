class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.5.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.5.0/naru-audio-darwin-arm64"
      sha256 "54ec1300590bbe7185c0b6fda677bdcb242d8d89d45312ae41722e6862cc3103"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.5.0/naru-audio-darwin-amd64"
      sha256 "c37f05f753574739750975755315b0bf9dedcae43321ab1785e3e664862f0237"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.5.0/naru-audio-linux-arm64"
      sha256 "e1d5991d2d5170856c93b5682b85384ce47291c5a92866f938d2635947061893"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.5.0/naru-audio-linux-amd64"
      sha256 "10741d456cdaf0dce398fd7235cc915e9042f3b6198eb62caa1cd3fd013c1965"
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
