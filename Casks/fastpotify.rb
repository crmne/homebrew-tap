cask "fastpotify" do
  version "0.5.0"
  sha256 "653f5a78aebcac6b789babeb423db0cdb0444accbbaee29926d9a37effeab874"

  url "https://github.com/crmne/fastpotify/releases/download/v#{version}/fastpotify-v#{version}-macos-universal.dmg"
  name "Fastpotify"
  desc "Native Spotify client"
  homepage "https://fastpotify.rocks"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Fastpotify.app"

  zap trash: [
    "~/Library/Application Support/me.paolino.fastpotify",
    "~/Library/Caches/me.paolino.fastpotify",
  ]

  caveats <<~EOS
    This build is not notarized yet, so macOS blocks the first launch.
    Either clear the quarantine flag:
      find /Applications/Fastpotify.app -exec xattr -d com.apple.quarantine {} + 2>/dev/null
    or open it once through System Settings, Privacy & Security: double-click
    the app, click Done, then scroll to the Security section and click
    "Open Anyway" next to the Fastpotify message. macOS remembers the choice.
  EOS
end
