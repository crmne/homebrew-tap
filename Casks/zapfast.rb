cask "zapfast" do
  version "0.21.2"
  sha256 "8ebf347ffe07ebda841d0d7ed1135775479e9147b4260cfe381aa75c8abd4847"

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
