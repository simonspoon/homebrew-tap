cask "wisp" do
  version "0.3.0"
  sha256 "d8d005271c393ce31928e006699c7299d5ffb7231dd74a05ce9ac9501eb43dc8"

  url "https://github.com/simonspoon/wisp/releases/download/v#{version}/Wisp_#{version}_universal.dmg"
  name "Wisp"
  desc "Desktop UI design tool for agents"
  homepage "https://github.com/simonspoon/wisp"

  depends_on macos: ">= :catalina"

  app "Wisp.app"

  zap trash: [
    "~/Library/Application Support/com.simonspoon.wisp",
    "~/Library/Caches/com.simonspoon.wisp",
    "~/Library/Preferences/com.simonspoon.wisp.plist",
    "~/Library/Saved Application State/com.simonspoon.wisp.savedState",
  ]
end
