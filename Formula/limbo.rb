class Limbo < Formula
  desc "CLI task manager designed for LLMs and AI agents"
  homepage "https://github.com/simonspoon/limbo"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.3.1/limbo-darwin-arm64"
      sha256 "2ab9bd491fc3318cbccb66dfbb7420bfaf79f24e2ff80499a878ceb746ef52e0"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.3.1/limbo-darwin-amd64"
      sha256 "abf1886ed55434789acd4ea72be07903fc29119769db10e4099252438a72efd8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/limbo/releases/download/v0.3.1/limbo-linux-arm64"
      sha256 "beffde7875a477ff954e91da8689fa662ab851fb713026f1110937cf45765685"
    else
      url "https://github.com/simonspoon/limbo/releases/download/v0.3.1/limbo-linux-amd64"
      sha256 "0ca7845cc07c6ef9104c867e3528d33918195bd31184733f8245734e76e2c303"
    end
  end

  def install
    binary = Dir["limbo-*"].first || "limbo"
    bin.install binary => "limbo"
  end

  test do
    assert_match "limbo", shell_output("#{bin}/limbo --help")
  end
end
