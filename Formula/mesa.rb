class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.0.0/mesa-darwin-arm64"
      sha256 "f960656c46bd2edf63797e67147cebdf3112d3119bb0e8ab2450912dbc4c250d"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.0.0/mesa-darwin-amd64"
      sha256 "4a94011efd8a09172cc1fc6acf01ef34aa4a06a6cad53870580219591062e43d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.0.0/mesa-linux-arm64"
      sha256 "f4acc6042c1c6167b4a8b06bf081bb39c2aa53810edd8b0c79afa83c7b4c73cb"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.0.0/mesa-linux-amd64"
      sha256 "760713e9092eacc7d6076b3d35a9e2698d1d7c126f5767bd64b049a6658ae8d1"
    end
  end

  def install
    binary = Dir["mesa-*"].first || "mesa"
    bin.install binary => "mesa"
  end

  test do
    assert_match "mesa", shell_output("#{bin}/mesa --help")
  end
end
