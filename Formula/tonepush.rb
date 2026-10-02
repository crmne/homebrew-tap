class Tonepush < Formula
  desc "Editor and tone library for Line 6 HX pedals and the StompStation PRO"
  homepage "https://tonepush.rocks"
  url "https://github.com/crmne/tonepush/releases/download/v0.8.0/tonepush-v0.8.0-macos-universal.tar.gz"
  sha256 "3c9eeb5fe0dbe5f559f95975371249bd40b1f80488a8885956bfbf36f4e8b5e8"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  def install
    bin.install "tonepush", "tonepush-gui"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      Quit HX Edit before connecting; only one editor can hold the device.
      For the TonePush app, install the cask instead:
        brew install --cask crmne/tap/tonepush
    EOS
  end

  test do
    assert_match "tonepush #{version}", shell_output("#{bin}/tonepush --version")
  end
end
