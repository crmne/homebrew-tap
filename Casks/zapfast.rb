cask "zapfast" do
  version "0.17.0"
  sha256 "70fddcb41b1134cf73807f5c55be19c9cbec655db55e6285640b4378d12bd791"

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
