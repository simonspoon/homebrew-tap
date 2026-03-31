class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.13.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.13.0/helios-darwin-arm64"
      sha256 "11e3005a9e935f6f8fc829e72082c2834d68e0775e8fa4dc8b7f3abba825008e"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.13.0/helios-darwin-amd64"
      sha256 "7e78abc7560251e5a5e1d28b8b596e1cbb832b4e87d9b50176dd00cf7484a1c3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.13.0/helios-linux-arm64"
      sha256 "cc377899e5bcecea43128eadf4b984c5929049adeabcd18033802cb068e90406"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.13.0/helios-linux-amd64"
      sha256 "8fe5856c96e4ce0ed95cf06276c281bda34873411a75957c9ad263990fc038dd"
    end
  end

  def install
    binary = Dir["helios-*"].first || "helios"
    bin.install binary => "helios"
  end

  test do
    assert_match "helios", shell_output("#{bin}/helios --help")
  end
end
