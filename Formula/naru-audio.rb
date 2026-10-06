class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.6.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.6.0/naru-audio-darwin-arm64"
      sha256 "6cd53cac5f942fd3d021f46d93ca4c6bfadcff8b09063cc61408b94183eba01e"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.6.0/naru-audio-darwin-amd64"
      sha256 "d164ada102b1541c6cd131a330c168b108351339029a58268b1f153990314a1b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.6.0/naru-audio-linux-arm64"
      sha256 "c7c3ffb2d122ec0e61d1d7504add4d09accb96b51e97ee517bd00f4739503059"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.6.0/naru-audio-linux-amd64"
      sha256 "0969856a6d9e842cd878c7276a7bac874bcc45b3897a6f214e6c5e1dfaa66a87"
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
