cask "zapfast" do
  version "0.14.0"
  sha256 "82c80c786eae0855db43b1ddb26f6f0b1a6ac3869c5a4ad646ab55bdd3867de1"

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
