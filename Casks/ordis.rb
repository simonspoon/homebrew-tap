cask "ordis" do
  version "0.1.2"
  sha256 "7670a902195dc8a37ee525e55ce66216ba01e4fadc4d86fae913429077675fa3"

  url "https://github.com/simonspoon/ordis/releases/download/v#{version}/Ordis_#{version}_universal.dmg"
  name "Ordis"
  desc "Desktop interface for Claude Code"
  homepage "https://github.com/simonspoon/ordis"

  depends_on macos: ">= :catalina"

  app "Ordis.app"

  zap trash: [
    "~/Library/Application Support/com.simonspoon.ordis",
    "~/Library/Caches/com.simonspoon.ordis",
    "~/Library/Preferences/com.simonspoon.ordis.plist",
    "~/Library/Saved Application State/com.simonspoon.ordis.savedState",
  ]
end
