cask "chat-with-work" do
  version "0.2.0"
  sha256 "17c777d1375fcf3fd1e034a195f1c70a2597014183d16e942768cc911616b919"

  url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v#{version}/chat-with-work-v#{version}-macos-universal.dmg"
  name "Chat with Work"
  desc "Desktop app for chatting and sharing folders with Chat with Work"
  homepage "https://github.com/crmne/chatwithwork-local-agent"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Chat with Work.app"

  zap trash: "~/Library/LaunchAgents/com.chatwithwork.cww-app.plist"

  caveats <<~EOS
    The cww command comes inside the app, and starting the agent from the
    app registers that copy. To stop the agent before removing the app:
      "#{appdir}/Chat with Work.app/Contents/MacOS/cww" daemon uninstall
  EOS
end
