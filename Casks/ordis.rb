cask "ordis" do
  version "0.16.1"
  sha256 "eb8e329a4f50e5909eca985399093b0a94d2fe7a94b1fdd6d485e67bedc0e7cb"

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
