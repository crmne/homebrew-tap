cask "zapfast" do
  version "0.16.2"
  sha256 "4798b6399e4b6e2cb81cc77a675eda3a9da21145cd35bb08b3e2e50d95e54e4d"

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
