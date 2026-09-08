class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.27.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.27.0/mesa-darwin-arm64"
      sha256 "a0897ae096138cc49ab93f3eb8f2312e62f72d0246ed29899b9daacabe0b29ae"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.27.0/mesa-darwin-amd64"
      sha256 "6236389c14ed5007c92be0c07f641131623c7c187935bae39d926e15526a7bcf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.27.0/mesa-linux-arm64"
      sha256 "8a4e32028d8c6771779235055e51cec950d8b9ad8f9a74c349398b156e61cc77"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.27.0/mesa-linux-amd64"
      sha256 "b42fbe8436fcaf32984740fee61f6ac53a6958cc1df03420fa8af6aba03adec0"
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
