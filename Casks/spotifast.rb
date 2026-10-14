cask "spotifast" do
  version "0.13.2"
  sha256 "7f98e66fb8d5445e72c311b9bec8cb7fb5922be0d7bb389deb67b136a5c9099c"

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
