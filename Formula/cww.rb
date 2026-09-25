class Cww < Formula
  desc "Chat with Work Local Agent: share folders with Chat with Work, read-only"
  homepage "https://github.com/crmne/chatwithwork-local-agent"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    # One universal binary, signed with Developer ID and notarized.
    url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.1.0/cww-v0.1.0-macos-universal.tar.gz"
    sha256 "6f99a0183784d43cb539ba86bd9f378469cdb29ce9d39a826e0a4751e92e25e4"
  end

  on_linux do
    on_intel do
      url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.1.0/cww-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bd1aee9dc6c9a927ca6c8598ded4c8448c313c4c86ce45ca243a83935baaf1a8"
    end
    on_arm do
      url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.1.0/cww-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4fb3258e3ffd86a91aff1f024cfc7d5d3592348fe5a2b15889a27f6d98991d0f"
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
