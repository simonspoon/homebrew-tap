class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.13.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.13.0/mesa-darwin-arm64"
      sha256 "c9a57bcf69d80662103fadac08b5d8fb437b93b152314522b2c04be455262b89"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.13.0/mesa-darwin-amd64"
      sha256 "eae7a2cc5383b23ff5b7f9ea825721f0783e4799d451b4169cbe7f7fe419ad0e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.13.0/mesa-linux-arm64"
      sha256 "8b5e0c3a4e86bab6eb7459cb4eb4725136d0a998e9731cf4cdfa9529c9228468"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.13.0/mesa-linux-amd64"
      sha256 "adb9455b94ff5d498f84e67e9f11c93fd3354dfe68e98662d55a876368b092da"
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
