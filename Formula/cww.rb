class Cww < Formula
  desc "Chat with Work Local Agent: share folders with Chat with Work, read-only"
  homepage "https://github.com/crmne/chatwithwork-local-agent"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    # One universal binary, signed with Developer ID and notarized.
    url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.2.0/cww-v0.2.0-macos-universal.tar.gz"
    sha256 "9d16a701fb6d257d01067abddc3ff4e0b9ac06240f2185f81e6317d9d81f4ca8"
  end

  on_linux do
    on_intel do
      url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.2.0/cww-v0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b226311a10f7368019011ae0d666d04e3f1abe5e94940b73d84c727da1fe07c1"
    end
    on_arm do
      url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.2.0/cww-v0.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cb9155d6bc6b6302fd8f4ff76954d128ab6ff024ac1ca6cd5be45b43d018ab64"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "cww"
    doc.install "README.md", "PROTOCOL.md", "SECURITY.md"
  end

  def caveats
    <<~EOS
      Pair this computer and choose what to share:
        cww
      Then keep the daemon running in the background:
        brew services start cww
      (or `cww daemon install`, which registers the same kind of LaunchAgent
      or systemd user unit without Homebrew).
    EOS
  end

  service do
    run [opt_bin/"cww", "daemon", "run"]
    keep_alive successful_exit: false
    process_type :background
    log_path var/"log/cww.log"
    error_log_path var/"log/cww.log"
  end

  test do
    assert_match "cww #{version}", shell_output("#{bin}/cww --version")
    ENV["CWW_HOME"] = testpath/"cww"
    assert_match "not running", shell_output("#{bin}/cww status")
  end
end
