class Mesa < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/mesa"
  version "0.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.9.0/mesa-darwin-arm64"
      sha256 "1a62cf12417a4046f459eb147f3e7a9052e14145d72690b5c44a5aa898922886"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.9.0/mesa-darwin-amd64"
      sha256 "9f0cac9bdc841e6bf9a229a0337bb72b6722754dc7a6be57d8f98251e94376c6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mesa/releases/download/v0.9.0/mesa-linux-arm64"
      sha256 "faf60366bbfb86ad361a0e91ab573b34539ae3898a86de275495d9efa4c02f2f"
    else
      url "https://github.com/simonspoon/mesa/releases/download/v0.9.0/mesa-linux-amd64"
      sha256 "de8277e9847dde58e01761134a5056f50f1ed534750e0bd2da48cecbb5a690bf"
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
