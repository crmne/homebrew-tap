cask "fastpotify" do
  version "0.7.1"
  sha256 "d6d6a6a6260cc8cf5e01b06b8aeb025f87909c08fd19f6b042baa5bae78b6d9c"

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
      find /Applications/Fastpotify.app -exec xattr -d com.apple.quarantine {} \; 2>/dev/null
    or open it once through System Settings, Privacy & Security: double-click
    the app, click Done, then scroll to the Security section and click
    "Open Anyway" next to the Fastpotify message. macOS remembers the choice.
  EOS
end
