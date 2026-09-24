cask "zapfast" do
  version "0.16.0"
  sha256 "bc51cf03cd34b4f72d2efdd5529dc2954ea73fb0fcb452ed26c6be5ae2147425"

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
