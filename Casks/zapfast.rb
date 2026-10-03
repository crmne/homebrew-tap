cask "zapfast" do
  version "0.19.0"
  sha256 "e90d92c083f8d0cd42cbaaa9e22cde87e95e24d9e8dbff6211779aa9a89d146d"

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
