cask "spotifast" do
  version "0.15.0"
  sha256 "7ee148690c4db87004bc1db3874021494d125a85a0c9be8a1f1efac6cefe8de1"

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
