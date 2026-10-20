cask "spotifast" do
  version "0.14.0"
  sha256 "c94ef0fcf8a10dda5a611333a960152ee261dd0154318a44ce1c6684c396ea4c"

  url "https://github.com/crmne/spotifast/releases/download/v#{version}/spotifast-v#{version}-macos-universal.dmg"
  name "Spotifast"
  desc "Native Spotify client"
  homepage "https://spotifast.rocks"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Spotifast.app"

  zap trash: [
    "~/Library/Application Support/me.paolino.spotifast",
    "~/Library/Caches/me.paolino.spotifast",
  ]
end
