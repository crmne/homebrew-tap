class Stompchain < Formula
  desc "Open-source editor for Line 6 Helix and HX pedals"
  homepage "https://stompchain.rocks"
  version "0.2.1"
  url "https://github.com/crmne/stompchain/releases/download/v#{version}/stompchain-v#{version}-macos-universal.tar.gz"
  sha256 "1916ecc90e422e5f2a07b009c14d0e8ea68cbec89c0720e7751a92b12f562277"
  license "MIT"

  def install
    bin.install "stompchain"
    bin.install "stompchain-gui"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      Quit HX Edit before connecting; only one editor can hold the device.

      Model names and artwork come from HX Edit's own data files. The app
      walks you through extracting them on first launch, or see:
        https://stompchain.rocks/getting-started/
    EOS
  end

  test do
    assert_match "stompchain #{version}", shell_output("#{bin}/stompchain --version")
  end
end
