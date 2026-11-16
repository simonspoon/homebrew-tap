class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.17.2"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.17.2/naru-audio-darwin-arm64"
      sha256 "6acf72c7ca6a62bd3304b28bd030c0029f0a300f7ca05dfb293b4c20991394ba"

      # MLX loads its kernels from mlx.metallib beside the binary.
      resource "metallib" do
        url "https://github.com/simonspoon/naru-audio/releases/download/v0.17.2/naru-audio-darwin-arm64.metallib"
        sha256 "28f63a7718f3235da8a861330d6ec4cfa8edfed32449e20e04ce42081812e328"
      end
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.17.2/naru-audio-darwin-amd64"
      sha256 "340693e0f192bed40ef870d89abf1b0b0ffa2154a25dd874b2dbec28856feb99"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.17.2/naru-audio-linux-arm64"
      sha256 "33650127876d0290227dda5cf64caf3605fa439f68c50ac3cdfcb91fee258b85"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.17.2/naru-audio-linux-amd64"
      sha256 "1a8eb497fa19ebfdc2ead8986a789759861c089b6d9278b11868a4c09873a618"
    end
  end

  def install
    binary = Dir["naru-audio-*"].first || "naru-audio"
    bin.install binary => "naru-audio"
    return if !OS.mac? || !Hardware::CPU.arm?

    resource("metallib").stage { bin.install "naru-audio-darwin-arm64.metallib" => "mlx.metallib" }
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
