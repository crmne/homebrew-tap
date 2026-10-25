class Cww < Formula
  desc "Chat with Work Desktop app, terminal interface and background agent"
  homepage "https://github.com/crmne/chatwithwork-desktop"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    # Universal CLI and app bundle, signed with Developer ID and notarized.
    url "https://github.com/crmne/chatwithwork-desktop/releases/download/v0.5.0/cww-v0.5.0-macos-universal.tar.gz"
    sha256 "594d98b0073268d028d5e43875289bc0cccfe506597a26f570e0cd2439edd131"
  end

  on_linux do
    depends_on "alsa-lib"
    # Dictation records through PipeWire's client library (libpipewire-0.3).
    depends_on "pipewire"
    # The window is a WebKitGTK 4.1 web view, which Homebrew doesn't carry:
    # the app uses the distribution's (see caveats).
    on_intel do
      url "https://github.com/crmne/chatwithwork-desktop/releases/download/v0.5.0/cww-app-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b934fd22a670b40bcdd67c2a8326e7aec037cf148658a8373d35ce023c23f42"
    end
    on_arm do
      url "https://github.com/crmne/chatwithwork-desktop/releases/download/v0.5.0/cww-app-v0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a47b4998619dbf63456cbae266071850c5ff60a97148434541d538a6b4182467"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    if OS.mac?
      prefix.install "Chat with Work.app"
      # Both entry points must resolve to the same cww, so daemon install
      # registers Homebrew's stable bin path instead of a versioned Cellar path.
      bin.install_symlink prefix/"Chat with Work.app/Contents/MacOS/cww"
      bin.install_symlink prefix/"Chat with Work.app/Contents/MacOS/cww-app"
    else
      bin.install "cww"
      libexec.install "cww-app"
      # cww-app finds cww beside itself.
      libexec.install_symlink bin/"cww"
      # The terminal's dictation records through Homebrew's ALSA and PipeWire.
      audio = %w[alsa-lib pipewire]
      (bin/"cww-app").write_env_script libexec/"cww-app",
        LD_LIBRARY_PATH: audio.map { |name| Formula[name].opt_lib }.join(":")
      # A desktop launcher does not inherit Homebrew's shell environment.
      inreplace "cww-app.desktop", "Exec=cww-app", "Exec=#{opt_bin}/cww-app"
      (share/"applications").install "cww-app.desktop"
      (share/"icons/hicolor/scalable/apps").install "cww-app.svg"
    end
    doc.install "README.md", "PROTOCOL.md", "SECURITY.md"
  end

  def caveats
    <<~EOS
      Open the desktop app with cww-app, or run cww for the terminal interface.
      Start the background agent from the app, or start it now and at login with:
        cww daemon install
      Check it with cww status. Nothing is shared until you pair and choose a folder.

      To make the app discoverable in your desktop's applications menu:
        macOS: use brew install --cask crmne/tap/chat-with-work
        Linux: add #{HOMEBREW_PREFIX}/share to XDG_DATA_DIRS in your desktop session
      Without a user service manager, run cww daemon run in a terminal.
      On Linux, the app's window needs your distribution's WebKitGTK 4.1, GTK 3
      and AppIndicator libraries (libwebkit2gtk-4.1-0 and
      libayatana-appindicator3-1 on Debian and Ubuntu).
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
    assert_match version.to_s, shell_output("#{bin}/cww-app --version")
    ENV["CWW_HOME"] = testpath/"cww"
    assert_match "not running", shell_output("#{bin}/cww status")
  end
end
