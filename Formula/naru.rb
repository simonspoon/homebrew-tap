class Naru < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/naru"
  version "1.10.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.10.0/naru-darwin-arm64"
      sha256 "69813c78d8005cfaab4fed0e11cfac56e0e6b57857e781cd1982bc1042abe7ba"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.10.0/naru-darwin-amd64"
      sha256 "6ffd695375769da470c46eae6ea3596adf4c7ec929c61b3af973d86b30b15ddd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.10.0/naru-linux-arm64"
      sha256 "11b0da007704c9bf353a36337c628eeaca1173e4389ebdce70a8bdb037e9802f"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.10.0/naru-linux-amd64"
      sha256 "385a8fad2be116c1fce0876fbaea69dea773368009bd23fb9764bb159b603c30"
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
