class Ivara < Formula
  desc "Claude Code session logging and analysis CLI"
  homepage "https://github.com/simonspoon/ivara"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/ivara/releases/download/v0.2.0/ivara-darwin-arm64"
      sha256 "a5b30149eb162c089aba6a7b3882d44c9deb222776c9524bb7f53ab986964da7"
    else
      url "https://github.com/simonspoon/ivara/releases/download/v0.2.0/ivara-darwin-amd64"
      sha256 "3485b0241b80d4f50d59c98b4b923f51c7b23a0a86f4b7341e2b4cf4087ae555"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/ivara/releases/download/v0.2.0/ivara-linux-arm64"
      sha256 "54064aaa62d4588a0f8dffd78862e632ea34eec3d758ded6b9d076893330a3e6"
    else
      url "https://github.com/simonspoon/ivara/releases/download/v0.2.0/ivara-linux-amd64"
      sha256 "9e7956500c25c261195e46ed186171f4d6fd1641acc14269439631b8b8ae027d"
    end
  end

  def install
    binary = Dir["ivara-*"].first || "ivara"
    bin.install binary => "ivara"
  end

  def caveats
    <<~EOS
      To wire ivara into Claude Code, run:

        ivara install-hooks

      This writes ~/.claude/hook-scripts/ivara-capture.sh and merges the
      canonical event entries into ~/.claude/settings.json (a .bak is saved
      alongside). Re-running is a no-op. To remove:

        ivara uninstall-hooks

      For project-scoped install, pass --scope project.
    EOS
  end

  test do
    assert_match "ivara", shell_output("#{bin}/ivara --help")
    assert_match "install-hooks", shell_output("#{bin}/ivara --help")
  end
end
