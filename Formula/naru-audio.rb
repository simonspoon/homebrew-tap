class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.15.1"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.15.1/naru-audio-darwin-arm64"
      sha256 "d49cacb6b6bd348503743b5d2d6f310539969cbcf874c07b849e01a202fb1f1b"

      # MLX loads its kernels from mlx.metallib beside the binary.
      resource "metallib" do
        url "https://github.com/simonspoon/naru-audio/releases/download/v0.15.1/naru-audio-darwin-arm64.metallib"
        sha256 "b142cec7b8b7b3cb71922fa10c67461ef89fb36338c683915e814afa4bb16887"
      end
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.15.1/naru-audio-darwin-amd64"
      sha256 "fde98262776f1a639bc9cedcc35597631f011db50171ee929ca611c81d72da13"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.15.1/naru-audio-linux-arm64"
      sha256 "8a767e2deafb00fa4e6553efe82235a84ca984376e6b61f4a84582ecd0b6e6b1"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.15.1/naru-audio-linux-amd64"
      sha256 "e8d4b068566043742284798cd5c60bc47161d88eda4f2b723dcdb3b9c514072b"
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
