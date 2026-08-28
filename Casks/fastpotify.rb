cask "fastpotify" do
  version "0.2.0"
  sha256 "8fae112231d19b5815d54f3c421f1b320a6ef0c1130f3f0140f7d25ee7100c71"

  url "https://github.com/crmne/fastpotify/releases/download/v#{version}/fastpotify-v#{version}-macos-universal.dmg"
  name "Fastpotify"
  desc "Fast, lightweight, native Spotify client"
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
      xattr -d com.apple.quarantine /Applications/Fastpotify.app
    or open it once through System Settings, Privacy & Security: double-click
    the app, click Done, then scroll to the Security section and click
    "Open Anyway" next to the Fastpotify message. macOS remembers the choice.
  EOS
end
