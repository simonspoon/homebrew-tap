class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.3.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.8/khora-darwin-arm64"
      sha256 "db3148631754ee482b59bc689db356eee60e461673ec1309c24c9067910620de"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.8/khora-darwin-amd64"
      sha256 "a47ac559631861121e068c50a154cc2f6cede2b434734c168ebd4632b39525cb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.3.8/khora-linux-arm64"
      sha256 "d0917922ad319f3506e7430e471a23f37d0c8ca8c66291fe65ce3f835490ff96"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.3.8/khora-linux-amd64"
      sha256 "0da793ebf66dad218cdb2e5d9e43cc65d52a59eb9ec53a8bd64288b06e8279ab"
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
