cask "zapfast" do
  version "0.16.5"
  sha256 "6d4ed0d02a120c89961190af694cdfa865882eac53c1a70dbbb3fbe8aa7a6c6e"

  url "https://github.com/crmne/zapfast/releases/download/v#{version}/zapfast-v#{version}-macos-universal.dmg"
  name "ZapFast"
  desc "Native WhatsApp client"
  homepage "https://zapfast.rocks"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "ZapFast.app"
end
