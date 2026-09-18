class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.2.0/mesa-darwin-arm64"
      sha256 "69263f660f1637e47f0b1d2d8b660b9625f3270e62cf8ff3a07ea8f7166fd8ea"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.2.0/mesa-darwin-amd64"
      sha256 "f80222dcde88b79f71cdaf58396f9a6fc398bc2f0833bd48d0ba4510c293e60b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.2.0/mesa-linux-arm64"
      sha256 "322e97314eab2b79d4ef80baf026b863d4c4661d3077a498ae52b676040c33d1"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.2.0/mesa-linux-amd64"
      sha256 "109ab9650c70f4869938225eafa3ccf3014593c52c3b9a32046c365ca2480fc1"
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
