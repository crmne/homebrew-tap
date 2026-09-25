cask "zapfast" do
  version "0.16.3"
  sha256 "e32de13714a439879c3edc39b916d59c64c102c45a96534093cc06b3eb686352"

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
