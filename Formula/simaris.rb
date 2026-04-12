class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.1.0/simaris-darwin-arm64"
      sha256 "81280663b216c41c1f91fbf90e1a3acb73f87437dd01b05648ea29d1fdb83d5b"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.1.0/simaris-darwin-amd64"
      sha256 "102a19c1a5a16d4b4510a8719dc4d677524b37d798eb59082fd857ee83e77272"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.1.0/simaris-linux-arm64"
      sha256 "5f6bb65d856655cff5cc973fc46e347105f32d257ba266ff12872bb4783ad7ef"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.1.0/simaris-linux-amd64"
      sha256 "6934e1f4785302ca001e1ce4c6388c466912d9c0337061dc0575ce161222bfa3"
    end
  end

  def install
    binary = Dir["simaris-*"].first || "simaris"
    bin.install binary => "simaris"
  end

  test do
    assert_match "simaris", shell_output("#{bin}/simaris --help")
  end
end
