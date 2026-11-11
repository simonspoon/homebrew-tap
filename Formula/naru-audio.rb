class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.17.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.17.0/naru-audio-darwin-arm64"
      sha256 "c22da77bfa50411771fde772c2d2795e3e3b82dc5a8a28b91b1cd667af0f69f4"

      # MLX loads its kernels from mlx.metallib beside the binary.
      resource "metallib" do
        url "https://github.com/simonspoon/naru-audio/releases/download/v0.17.0/naru-audio-darwin-arm64.metallib"
        sha256 "28f63a7718f3235da8a861330d6ec4cfa8edfed32449e20e04ce42081812e328"
      end
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.17.0/naru-audio-darwin-amd64"
      sha256 "5deb54782121971e8e314cf825f1183a9af915c386335a2c55955a5bab1fbd05"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.17.0/naru-audio-linux-arm64"
      sha256 "7b6a51be6b232f9022c5419d4795497395162b4d33d329cd47f5a848c3560cd0"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.17.0/naru-audio-linux-amd64"
      sha256 "a2dca67803dcdbb7112ee1ef4a725e4e5e928f2a0e4c7b490e1df8a98172dbe2"
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
