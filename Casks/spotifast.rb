cask "spotifast" do
  version "0.14.1"
  sha256 "921a4b2bd40d9662544fc92f5c0c9186388dc443ce669491c3e4b9b82ef28a76"

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
