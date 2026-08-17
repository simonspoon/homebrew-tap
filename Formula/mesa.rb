class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.21.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.21.0/mesa-darwin-arm64"
      sha256 "f49b4adf09e4856915a849dfdd184d825c4a40781a194a82fc9c74093a2e0d5e"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.21.0/mesa-darwin-amd64"
      sha256 "312060349e0598a4f94b6f0bb5a4c3eef98ae17453f13b4ddf9e115bf98576a9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.21.0/mesa-linux-arm64"
      sha256 "54104c2b839034d721d70509bb7bfa53d532781efaefaa0a967eba9ba2003907"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.21.0/mesa-linux-amd64"
      sha256 "6a30dc0ac5b619546539ecc0b5b20d7b8f16b033962058945a49b213a349b461"
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
