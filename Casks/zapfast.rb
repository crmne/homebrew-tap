cask "zapfast" do
  version "0.20.0"
  sha256 "2cbcaac902a846801da68770d81dcc34d394b27862dee31663c1fe966926b97a"

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
