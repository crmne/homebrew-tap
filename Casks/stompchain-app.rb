cask "stompchain-app" do
  version "0.2.1"
  sha256 "00b71acc8d780519e1790712b6a8a850cf96ef41d90f1b080819ecb1953032bd"

  url "https://github.com/crmne/stompchain/releases/download/v#{version}/stompchain-v#{version}-macos-universal.dmg"
  name "stompchain"
  desc "Open-source editor for Line 6 Helix and HX pedals"
  homepage "https://stompchain.rocks"

  app "stompchain.app"

  caveats <<~EOS
    Quit HX Edit before connecting; only one editor can hold the device.

    If macOS refuses to open the app, right-click it and choose Open once;
    this disappears when notarized builds ship.
  EOS
end
