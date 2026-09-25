cask "zapfast" do
  version "0.16.4"
  sha256 "78d0ba6fbe28ee732ebec78c9dbdf884be8d599ffb5d8750e96d8d41c3c7eac4"

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
