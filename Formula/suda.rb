class Suda < Formula
  desc "Structured memory and knowledge management CLI for AI agent workflows"
  homepage "https://github.com/simonspoon/suda"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/suda/releases/download/v0.2.0/suda-darwin-arm64"
      sha256 "73352aa801a6a92aac7fa35053f6a7f2d18d6b04351578708c2d61c166a2d72a"
    else
      url "https://github.com/simonspoon/suda/releases/download/v0.2.0/suda-darwin-amd64"
      sha256 "9fef5ad36e91d3f566ae716a2a49b882bcf6609b03e397645bfaa96ffe4c438f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/suda/releases/download/v0.2.0/suda-linux-arm64"
      sha256 "f4978a647b01009811683edac56125b1321c7828c89db06f8e1adbd8a33b4c6a"
    else
      url "https://github.com/simonspoon/suda/releases/download/v0.2.0/suda-linux-amd64"
      sha256 "f2840da3d7a15bd5372e2e9c0cc96d33287330b0fde82caa044d74178728228c"
    end
  end

  def install
    binary = Dir["suda-*"].first || "suda"
    bin.install binary => "suda"
  end

  test do
    assert_match "suda", shell_output("#{bin}/suda --help")
  end
end
