class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.4.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.4.0/naru-darwin-arm64"
      sha256 "93fde43b90ddebe1e566bddad940d764b706e537a7d5f9f4312b6341a221aa8f"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.4.0/naru-darwin-amd64"
      sha256 "548fa4b67742bd8a8d907e5b49f300dcfbfd248e1470158ff49ccf29b0e7d326"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.4.0/naru-linux-arm64"
      sha256 "ff7e0fb72b5eaee2c2bb24183dd9a8b48fa6809e2a4af7858887a4cdd2367103"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.4.0/naru-linux-amd64"
      sha256 "e66b05864a666194ad8b338b07e9abc8ba834ec4b264f8e17461cb58b29e1b81"
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
