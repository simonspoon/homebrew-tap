class Naru < Formula
  desc "Local-first workspace for planning and running work with Claude Code agents"
  homepage "https://github.com/simonspoon/naru"
  version "2.1.0"
  license "MIT"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.1.0/naru-darwin-arm64"
      sha256 "c6c6b705d07a9990f5e29459ef703bb696efbc44a09236ae1b17dab64f56fc06"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.1.0/naru-darwin-amd64"
      sha256 "1c56cad7f803c0dd1de4eb9ee280f834217ebaff614df21b0a22b6f7ce83b95f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v2.1.0/naru-linux-arm64"
      sha256 "510ca240db6836e2f7cbb8a4e6bce19244918004ce640813e1656c5baac0e23d"
    else
      url "https://github.com/simonspoon/naru/releases/download/v2.1.0/naru-linux-amd64"
      sha256 "fe7f939675ac7ec38a76646565593683fc7d04bb73bb93febe8e4373d51ba950"
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
