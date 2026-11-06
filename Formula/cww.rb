class Cww < Formula
  desc "Chat with Work Desktop app, terminal interface and background agent"
  homepage "https://github.com/crmne/chatwithwork-desktop"
  version "0.14.1"
  license "GPL-3.0-only"

  on_macos do
    # The bundled Node runtime needs macOS 13.5 (Homebrew names only Ventura).
    depends_on macos: :ventura
    # Universal CLI and app bundle, signed with Developer ID and notarized.
    url "https://github.com/crmne/chatwithwork-desktop/releases/download/v0.14.1/cww-v0.14.1-macos-universal.tar.gz"
    sha256 "6137de62ed3a20be04928260e96c0f48c44b17ac9975494262692c20eb7a2c20"
  end

  on_linux do
    depends_on "alsa-lib"
    # Dictation records through PipeWire's client library (libpipewire-0.3).
    depends_on "pipewire"
    # The window is a WebKitGTK 4.1 web view, which Homebrew doesn't carry:
    # the app uses the distribution's (see caveats).
    on_intel do
      url "https://github.com/crmne/chatwithwork-desktop/releases/download/v0.14.1/cww-app-v0.14.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e2ee191baef55b04dc70c723a2342b4d4972914a37e1a886834e35342fb413c5"
    end
    on_arm do
      url "https://github.com/crmne/chatwithwork-desktop/releases/download/v0.14.1/cww-app-v0.14.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "843861ec75a7baadaa239fe235a0395566c0311c9dad60321b27eccfc1eff30d"
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
      (libexec/"chatwithwork").install "browser-engine"
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
      libayatana-appindicator3-1 on Debian and Ubuntu). Commands also need
      bubblewrap, slirp4netns, util-linux and nft-backed iptables from your
      distribution, available on the background service's PATH.
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
