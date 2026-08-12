class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.17.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.17.0/mesa-darwin-arm64"
      sha256 "4170c4d01c33b2048af04738ba09afa4d238ea7e17072da843e8760babf5fe92"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.17.0/mesa-darwin-amd64"
      sha256 "f0e2dda341d61541f70f93a3189ffc0ed76ccc0a8615621989d2e4cb2a87e7cd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.17.0/mesa-linux-arm64"
      sha256 "07d7630f8c5ca0b75d50ad0b96bb9ba40366151b1863f63e61dc0f287a42c1c5"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.17.0/mesa-linux-amd64"
      sha256 "a38fa8c26859aafa6c98e99ec53d7fe54751fb576b6d35ffe7160803fa6ed4d2"
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
