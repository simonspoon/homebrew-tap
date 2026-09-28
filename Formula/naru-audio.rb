class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.2.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.2.0/naru-audio-darwin-arm64"
      sha256 "3ea47ea3e12b52d4c65c8a7e27417790f3a537a21f1f94ad4da4ce4c48501b0f"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.2.0/naru-audio-darwin-amd64"
      sha256 "527890b8ca03b5df8d67c69190ffb917fba33e1e74a859956525a2bfecfec427"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.2.0/naru-audio-linux-arm64"
      sha256 "9eed8a00dfeb49429dd09ce2850fe64af7962f54d624d5b0830ccdb3d26f3c91"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.2.0/naru-audio-linux-amd64"
      sha256 "f5edea06d2114392186b907e2acb7f0ada40820f081c4e34a62fe00bea96ccdd"
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
