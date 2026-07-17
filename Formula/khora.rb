class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.13"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.13/khora-darwin-arm64"
      sha256 "2ad1cfd062485a053623584d6dfa7ab76896bdde11232ee8b971d612d5b5ce10"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.13/khora-darwin-amd64"
      sha256 "3d5a363e9c65343313fe4e2400c2eb30717a20c3cc646feebf0956561da11c6b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.13/khora-linux-arm64"
      sha256 "0db07ca5cb8be3961113a751aca42e952590996b3e55b015d1d04f06adee4911"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.13/khora-linux-amd64"
      sha256 "8343f06b6aa7eed523f587c6abf3343d047debd1ddec81d3f53627f3aa21bac6"
    end
  end

  def install
    binary = Dir["khora-*"].first || "khora"
    bin.install binary => "khora"
  end

  test do
    assert_match "Web app QA automation", shell_output("#{bin}/khora --help")
  end
end
