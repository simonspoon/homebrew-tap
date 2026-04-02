cask "ordis" do
  version "0.11.0"
  sha256 "fb80f9e6b36f65ea266b48c4bac1d2bb0477ffef2202bdde2f83dee7644a2f71"

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
