class Simaris < Formula
  desc "Knowledge management CLI with SQLite, FTS5, and graph-based linking"
  homepage "https://github.com/simonspoon/simaris"
  version "0.3.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.3/simaris-darwin-arm64"
      sha256 "7ed90371c7d20468d6954a6b668081d67a59114ce2815b5d170b35851c3455f3"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.3/simaris-darwin-amd64"
      sha256 "ab3f8e9257267615bc5d0f6ed9c9e1383fdc6a57275bcae3240d2743a767ca85"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.3/simaris-linux-arm64"
      sha256 "18adb69c3c5defdc26e7ee1f6ae8858f19591d45703b575bdd8ed41187757e7f"
    else
      url "https://github.com/simonspoon/simaris/releases/download/v0.3.3/simaris-linux-amd64"
      sha256 "96dacb7bc11a00e4d1948499ae5c28d95e2f8234e2684d265aafcd949cb90bb9"
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
