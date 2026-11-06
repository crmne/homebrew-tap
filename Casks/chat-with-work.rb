cask "chat-with-work" do
  version "0.14.0"
  sha256 "42e3ba56fbfc5e7490251ba18103ccfa54c6a6ac0a34f11a56a857c4cc4d0831"

  url "https://github.com/crmne/chatwithwork-desktop/releases/download/v#{version}/chat-with-work-v#{version}-macos-universal.dmg"
  name "Chat with Work Desktop"
  name "Chat with Work"
  desc "Desktop app for chatting and sharing folders with Chat with Work"
  homepage "https://github.com/crmne/chatwithwork-desktop"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The formula exposes cww on PATH without conflicting with existing installs.
  depends_on formula: "crmne/tap/cww"
  depends_on macos: ">= :ventura"

  app "Chat with Work.app"

  zap trash: "~/Library/LaunchAgents/com.chatwithwork.cww-app.plist"

  caveats <<~EOS
    Open Chat with Work in Applications, or run cww for the terminal interface.
    Start the background agent from the app, or start it now and at login with:
      cww daemon install
    Check it with cww status. To stop the agent before removing the app:
      "#{appdir}/Chat with Work.app/Contents/MacOS/cww" daemon uninstall
  EOS
end
