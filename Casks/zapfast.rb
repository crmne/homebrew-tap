cask "zapfast" do
  version "0.21.3"
  sha256 "f469c913dd16e1ec9542234bca56ec7251a3dac027fa25844d7654956e61b7f3"

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
