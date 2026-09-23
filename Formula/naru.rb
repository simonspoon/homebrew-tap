class Naru < Formula
  desc "Local-first project and task management for humans and agents"
  homepage "https://github.com/simonspoon/naru"
  version "1.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.8.0/naru-darwin-arm64"
      sha256 "3e295866f69ddb3f4c532d8f2cd5999ce6f83f0e60d1d323460f6b848244fb68"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.8.0/naru-darwin-amd64"
      sha256 "2b107c37ada11c575ddc5f3f6b01e2b4fee08cb27fe1ab7a3d2f045cc3946567"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/naru/releases/download/v1.8.0/naru-linux-arm64"
      sha256 "43b5b504b7dc2b392156078b9c8c532a40950ccc73e55094b339132d604cd2c3"
    else
      url "https://github.com/simonspoon/naru/releases/download/v1.8.0/naru-linux-amd64"
      sha256 "124c39fb3b4b547ba4a407b68229b654f5174275d11e89e364dd47d4a6ac5949"
    end
  end

  def install
    binary = Dir["naru-*"].first || "naru"
    bin.install binary => "naru"
    bin.install_symlink "naru" => "mesa"
  end

  test do
    assert_match "naru", shell_output("#{bin}/naru --help")
    assert_match "mesa", shell_output("#{bin}/mesa --help")
  end
end
