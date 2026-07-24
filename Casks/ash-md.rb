cask "ash-md" do
  version "0.2.0"
  sha256 "7f8994f94ab81b50a4ae043022272e0b252181d8aad418edfcd33c4b645e5f37"

  url "https://github.com/simonspoon/ash-md/releases/download/v#{version}/ash-md_#{version}_universal.dmg"
  name "ash-md"
  desc "Native markdown viewer/editor for macOS"
  homepage "https://github.com/simonspoon/ash-md"

  depends_on macos: ">= :catalina"

  app "ash-md.app"

  # Puts `ash-md` on PATH. The bundled launcher resolves its own .app by following this
  # symlink back to Contents/Resources and walking up two levels, so it keeps working
  # wherever the cask installs the app.
  binary "#{appdir}/ash-md.app/Contents/Resources/ash-md"

  zap trash: [
    "~/Library/Application Support/com.sjspoon.ash-md",
    "~/Library/Caches/com.sjspoon.ash-md",
    "~/Library/Preferences/com.sjspoon.ash-md.plist",
    "~/Library/Saved Application State/com.sjspoon.ash-md.savedState",
  ]
end
