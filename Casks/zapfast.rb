cask "zapfast" do
  version "0.21.1"
  sha256 "a94898fc6b50025505a48734a560f95170d0b84eb2b163dddf472deb4a37e74f"

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
