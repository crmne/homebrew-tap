cask "zapfast" do
  version "0.18.1"
  sha256 "ab217359db5a68b3624563eab94ee62b7f6279fc34f2b3d4713a35560f1ceaa2"

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
