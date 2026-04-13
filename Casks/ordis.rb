cask "ordis" do
  version "0.14.1"
  sha256 "91eafb407c415a1d2cb135a64c8fd7aeaf27b3493e44d1b5fe0f2c18e4a3c4a0"

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
