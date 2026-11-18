class NaruAudio < Formula
  desc "Local speech-to-text and text-to-speech daemon for Naru"
  homepage "https://github.com/simonspoon/naru-audio"
  version "0.18.1"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.18.1/naru-audio-darwin-arm64"
      sha256 "37a7becedf12487037b2546b53559ac60de9f98d71bbbb227a9b7cd34c95366e"

      # MLX loads its kernels from mlx.metallib beside the binary.
      resource "metallib" do
        url "https://github.com/simonspoon/naru-audio/releases/download/v0.18.1/naru-audio-darwin-arm64.metallib"
        sha256 "28f63a7718f3235da8a861330d6ec4cfa8edfed32449e20e04ce42081812e328"
      end
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.18.1/naru-audio-darwin-amd64"
      sha256 "7003ab09520f7be7d289c39fba456ede3a58db4f8a1de3c82e3a2dacfecdf180"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.18.1/naru-audio-linux-arm64"
      sha256 "1accee6146ef20333ac544f4c609e5630b1c75b52b006fdda5e7d247943f026a"
    else
      url "https://github.com/simonspoon/naru-audio/releases/download/v0.18.1/naru-audio-linux-amd64"
      sha256 "c995fb86bd0365d8b94d904efff0ccf85f965884c6ae872d08ebd39402e04fbe"
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
