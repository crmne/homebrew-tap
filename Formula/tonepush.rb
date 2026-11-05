class Tonepush < Formula
  desc "Editor and tone library for Line 6 HX pedals and the StompStation PRO"
  homepage "https://tonepush.rocks"
  url "https://github.com/crmne/tonepush/releases/download/v0.12.1/tonepush-v0.12.1-macos-universal.tar.gz"
  sha256 "69e7870c961c5aad2c2a5c9beb1fd93fdef71a12a62fb95210920afe36613fd1"
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
