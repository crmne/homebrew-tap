cask "zapfast" do
  version "0.15.0"
  sha256 "c528ad216760d3834bf6fb6ddcce23ddd4e86f9227cd98e0dc3762e677307fdf"

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
