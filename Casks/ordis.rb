cask "ordis" do
  version "0.15.0"
  sha256 "65bd56500b0db59fa2c69da15fd04a55c69c4901971dc61ded70f95dbcf59811"

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
