cask "zapfast" do
  version "0.20.1"
  sha256 "2b8b3f6ebb1adaa749a95dec9eb50d86cd04f46960d47667056e6d17c6be8958"

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
