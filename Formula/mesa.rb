class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.29.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.29.0/mesa-darwin-arm64"
      sha256 "42d35d3eaef65d510160253cdc23954404bfaf8111c0fa8b0581b82a26c427d8"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.29.0/mesa-darwin-amd64"
      sha256 "9eead2da1db72e4105bd47133fca5ebebfb6e837df4f9535468887368c022b42"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.29.0/mesa-linux-arm64"
      sha256 "5effaaa14cced6c8a5722a70e823636d148e647a3f239b90b6c401f97e3e7edf"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.29.0/mesa-linux-amd64"
      sha256 "9049ab8545c311693a880a70c8669497f37f6f8a453c5d6f168565f4115f6da8"
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
