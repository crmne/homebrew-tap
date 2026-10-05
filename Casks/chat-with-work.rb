cask "chat-with-work" do
  version "0.3.0"
  sha256 "37e01bae7fa0476953f4b2123fd7c8efed48af41ed316f2e7aa4475255425632"

  url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v#{version}/chat-with-work-v#{version}-macos-universal.dmg"
  name "Chat with Work"
  desc "Desktop app for chatting and sharing folders with Chat with Work"
  homepage "https://github.com/crmne/chatwithwork-local-agent"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The formula exposes cww on PATH without conflicting with existing installs.
  depends_on formula: "crmne/tap/cww"
  depends_on macos: ">= :big_sur"

  app "Chat with Work.app"

  zap trash: "~/Library/LaunchAgents/com.chatwithwork.cww-app.plist"

  caveats <<~EOS
    Open Chat with Work in Applications, or run cww for the terminal interface.
    Choose Start Local Agent in the app, or start it now and at login with:
      cww daemon install
    Check it with cww status. To stop the agent before removing the app:
      "#{appdir}/Chat with Work.app/Contents/MacOS/cww" daemon uninstall
  EOS
end
