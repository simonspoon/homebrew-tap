class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.4.0/khora-darwin-arm64"
      sha256 "e64fbc487002feecb64827024496c51b7a350bf878f12576b1564edf0d229673"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.4.0/khora-darwin-amd64"
      sha256 "6261e195f1cbdbac5087a2eef5484f2572bf33c9eee2cd2facc7df4a54752cad"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.4.0/khora-linux-arm64"
      sha256 "b11dc264797821b9c2e4894d444a44359f96473a135ffab7bbe1a591fb1170cc"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.4.0/khora-linux-amd64"
      sha256 "a4ff476847b18f55b55ffcac8f977882fdd28389d08904d2029d098d227a774e"
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
