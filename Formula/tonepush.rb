class Tonepush < Formula
  desc "Editor and tone library for Line 6 HX pedals and the StompStation PRO"
  homepage "https://tonepush.rocks"
  url "https://github.com/crmne/tonepush/releases/download/v0.11.0/tonepush-v0.11.0-macos-universal.tar.gz"
  sha256 "11dd28503cd4755ace521ef10197b6fd0d7c7ead18d831006e415f021e586e52"
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
