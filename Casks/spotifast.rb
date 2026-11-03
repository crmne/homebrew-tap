cask "spotifast" do
  version "0.17.1"
  sha256 "874d2db6d3eedc555e1a1b9458224a159cf753abad295b36fa89bd2dde3b2238"

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
