class Tonepush < Formula
  desc "Editor and tone library for Line 6 HX pedals and the StompStation PRO"
  homepage "https://tonepush.rocks"
  url "https://github.com/crmne/tonepush/releases/download/v0.9.1/tonepush-v0.9.1-macos-universal.tar.gz"
  sha256 "309b3a85678ab94a7f7692f46a60ca8addccd196ef1ff30904e7d5c729341822"
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
