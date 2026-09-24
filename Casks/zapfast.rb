cask "zapfast" do
  version "0.16.1"
  sha256 "2aec9d5d1e9bc9e1dfd98c5600316a7fda335a4ecb489d4b284a8d22959c51df"

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
