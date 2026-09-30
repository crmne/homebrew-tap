cask "zapfast" do
  version "0.18.2"
  sha256 "9f1ed04ad91c3300c4edaa70106d9ee5fb7c71a9975441f300fc4861668bb81c"

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
