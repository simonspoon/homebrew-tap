class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.16.0"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.16.0/naru-audio-darwin-arm64"
      sha256 "1fd4e3db20866b48c64d9c022da08ee6bba5d181ebabe787097a7745beb6b91d"

      # MLX loads its kernels from mlx.metallib beside the binary.
      resource "metallib" do
        url "https://github.com/simonspoon/naru-audio/releases/download/v0.16.0/naru-audio-darwin-arm64.metallib"
        sha256 "28f63a7718f3235da8a861330d6ec4cfa8edfed32449e20e04ce42081812e328"
      end
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.16.0/naru-audio-darwin-amd64"
      sha256 "12b5ac2023cb6535774586592d324abe49ef5644e5ae8250444b28f69dc151c5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.16.0/naru-audio-linux-arm64"
      sha256 "7210d5aa69fe48bc9dd5c32fa983f16e49c309470079e91750d05c82be9fb38b"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.16.0/naru-audio-linux-amd64"
      sha256 "506a765132f861e6a043730aef09352960e12ed9e731234462891149287cd772"
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
