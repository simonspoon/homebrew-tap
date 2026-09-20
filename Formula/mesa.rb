class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "1.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.3.0/mesa-darwin-arm64"
      sha256 "4bc841f6509bb47ca207cab7e5d396a5af644c35381163c1738075aa4d751875"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.3.0/mesa-darwin-amd64"
      sha256 "a804209aa3241a9363d9266ea57d0182fb8c3bda84df2351edb159372a7e050f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v1.3.0/mesa-linux-arm64"
      sha256 "f067febe0ea54d896a540800b4dd73646ec5052fdb22996acd9800ba3e7f4108"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v1.3.0/mesa-linux-amd64"
      sha256 "37b8b4dd886b8ef4fe092254aa4846f71f75b501e572471072fd58ce6de51a33"
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
