cask "zapfast" do
  version "0.21.0"
  sha256 "d2ccf01ae2515a733026b9b3a33400eb6ca2891ebfb98fb3af036f0da155848e"

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
