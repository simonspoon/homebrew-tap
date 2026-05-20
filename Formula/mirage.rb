class Mirage < Formula
  desc "Swagger 2.0 mock API server with SQLite-backed fake data"
  homepage "https://github.com/simonspoon/mirage"
  version "0.6.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.6.1/mirage-darwin-arm64"
      sha256 "b71a9998d0cd5d66bdaf82efbc037176326337d0a81fbd6e28c2ff63057c893d"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.6.1/mirage-darwin-amd64"
      sha256 "4797bb9b690c1645268703c37ea62b5dddab81548fafd7ed7c63ef238724edcc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/mirage/releases/download/v0.6.1/mirage-linux-arm64"
      sha256 "d6f43f0b8423247da3634f903d64282fd485a763dbabba60c50fb80a7eb0b72d"
    else
      url "https://github.com/simonspoon/mirage/releases/download/v0.6.1/mirage-linux-amd64"
      sha256 "9d7bd15095d55e31ed673bcdb2ead910268281f4b38388dc65d82c58b1469ce9"
    end
  end

  def install
    binary = Dir["mirage-*"].first || "mirage"
    bin.install binary => "mirage"
  end

  test do
    assert_match "Swagger 2.0 mock API server", shell_output("#{bin}/mirage --help")
  end
end
