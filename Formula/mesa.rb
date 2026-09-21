class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "1.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.4.0/mesa-darwin-arm64"
      sha256 "360c7891495478a32fdbe44cdc91ed5f11e482e033249b4371163cf8540cd8dc"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.4.0/mesa-darwin-amd64"
      sha256 "578e65619875820df300e892a1dbe0774ad712636dfa031e5f7d7a748ac39d2c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.4.0/mesa-linux-arm64"
      sha256 "a69cc7ead82d3c4324c004be498ea2ac2dc7a6f433d5d7ac1b33bdd49e84be42"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.4.0/mesa-linux-amd64"
      sha256 "31f2e77de0408dfc81f4f296d2c8914f28a30bc926d2cbaf81583176e13dced2"
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
