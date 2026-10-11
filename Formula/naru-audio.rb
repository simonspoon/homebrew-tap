class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.8.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.8.0/naru-audio-darwin-arm64"
      sha256 "2378e023dade0ed47a1c0972493fa48b9c1fc2735446975a667c193edb0d822d"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.8.0/naru-audio-darwin-amd64"
      sha256 "a7e213a95bdab08c015daf8ecfac8d83bc86fa7e2bae582bfadfee699e286b81"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.8.0/naru-audio-linux-arm64"
      sha256 "abc77613a44b7e4cafd3355a1682cdeafcd3a29c37a8501ad2f125596aef3476"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.8.0/naru-audio-linux-amd64"
      sha256 "ca93feb19b648af37e5c5a752121d214664cff45502c76b4d37d313cfd572d6e"
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
