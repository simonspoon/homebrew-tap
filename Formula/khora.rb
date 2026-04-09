class Khora < Formula
  desc "Web app QA automation CLI via Chrome DevTools Protocol"
  homepage "https://github.com/simonspoon/khora"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.2.0/khora-darwin-arm64"
      sha256 "d2e6219621339ad3eb5e3bd16154ab9d3e3572609d4fdfbd97f3fd6e90db04ef"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.2.0/khora-darwin-amd64"
      sha256 "a4efec0d9d77a0d1b3b3c0f6b1815d9e0e1046ab11416b324fc1aea188ffdb54"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/khora/releases/download/v0.2.0/khora-linux-arm64"
      sha256 "ef576df69f5bb84dd1c25dd0bb61cc92719c2679a5a24fdb7d4993516c94dee0"
    else
      url "https://github.com/simonspoon/khora/releases/download/v0.2.0/khora-linux-amd64"
      sha256 "450eb76ff829bdfc28c6acf0887e6ff4f3691f4d5041abc11047405d7d7412e8"
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
