class Ivara < Formula
  desc "Claude Code session logging and analysis CLI"
  homepage "https://github.com/simonspoon/ivara"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/ivara/releases/download/v0.1.0/ivara-darwin-arm64"
      sha256 "f68e3bd4e98f5675f48b0a818633adc924664ebfc6a76b90334f43da036c4e4c"
    else
      url "https://github.com/simonspoon/ivara/releases/download/v0.1.0/ivara-darwin-amd64"
      sha256 "59f15d485ef132645732db9ed3e7eb0341c00001912579e3e8dff1340a127f48"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/ivara/releases/download/v0.1.0/ivara-linux-arm64"
      sha256 "6806affda3e78bda40849faa9a496dbf9bd17155e6405a8588683a61d444cb49"
    else
      url "https://github.com/simonspoon/ivara/releases/download/v0.1.0/ivara-linux-amd64"
      sha256 "28e29d0da822f57e0e4b87626035d18e1b1fe83ced15ea0cd7c6a7370b0aec5c"
    end
  end

  def install
    binary = Dir["ivara-*"].first || "ivara"
    bin.install binary => "ivara"
  end

  test do
    assert_match "ivara", shell_output("#{bin}/ivara --help")
  end
end
