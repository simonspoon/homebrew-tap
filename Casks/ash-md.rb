cask "ash-md" do
  version "0.1.0"
  sha256 "affe734456b9a72ebeeb5a8d055ce5515f635bbfc96ad006722a7eabd24199b8"

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
