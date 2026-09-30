class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "1.14.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.14.0/naru-darwin-arm64"
      sha256 "545505b4c22d3c337ddbbdfebb0d667701091f5afbe2aa9cc44540d498baeb9b"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.14.0/naru-darwin-amd64"
      sha256 "c76a6574ac9b3f2240e7c0df982913708cf5ac81ab4819d0e8537eab4b9313f7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.14.0/naru-linux-arm64"
      sha256 "1b66e5a96502808742e920f7fdaf5e9b071eb498a665bc54d1a17a9f0116ed88"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.14.0/naru-linux-amd64"
      sha256 "6c9495036c5d05c91424f8e82daeefcf9f7dc71550aca22d8a357464534e61bd"
    end
  end

  def install
    binary = Dir["naru-*"].first || "naru"
    bin.install binary => "naru"
  end

  test do
    assert_match "naru", shell_output("#{bin}/naru --help")
  end
end
