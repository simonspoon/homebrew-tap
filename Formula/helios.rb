class Helios < Formula
  desc "Tree-sitter code indexing CLI with SQLite storage"
  homepage "https://github.com/simonspoon/helios"
  version "0.35.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.35.0/helios-darwin-arm64"
      sha256 "66311f13ec355c34137988e5ba51d55297956484bb2cc011501664e247278145"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.35.0/helios-darwin-amd64"
      sha256 "f35c4f4e80658ad0c673426b9374e2ef0222e34a947e166291489d12afb17ba1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/helios/releases/download/v0.35.0/helios-linux-arm64"
      sha256 "3ba2bd316dd40aebcaac2e6aef170ff4e76afa574e2b62200091be66d08e7967"
    else
      url "https://github.com/simonspoon/helios/releases/download/v0.35.0/helios-linux-amd64"
      sha256 "eeaba4080b2674cebfa9ce2782929c83ed6ea9fc9aded2925a187b05ab7916c4"
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
