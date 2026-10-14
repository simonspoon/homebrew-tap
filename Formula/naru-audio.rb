class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.9.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.9.0/naru-audio-darwin-arm64"
      sha256 "5a0b0e6859482b6a8c132281d2e3d67f322ca0cb0b417f580c86e08ef48e2a51"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.9.0/naru-audio-darwin-amd64"
      sha256 "a51b53f046cc9bba0efaff414c61f0543a6eab68d8c6a05242221e3f3ccff0fc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.9.0/naru-audio-linux-arm64"
      sha256 "6234281a098373efd0f1629d7c696153f0bcd56dd6f0bb17061b31138c2b9db1"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.9.0/naru-audio-linux-amd64"
      sha256 "96a48921abd6b4ed31891182bf443c11d92db88a010ef6ad2cfc1fe8337557b3"
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
